import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class testApp extends StatefulWidget {
  @override
  _testAppState createState() => _testAppState();
}
class _testAppState extends State<testApp> {
  @override
  late double _userInput;
  String? _convertedMeasure;
  String? errorMessage;
  String? _startValue;
  var fromUnits = [
    'Centimeter',
    'Meters',
    'Kilometer',
    'Grams',
    'Kilograms (kg)',
    'Inch',
    'Feet',
  ];
  final Map<String,int> measuresMap ={
    'Centimeter': 0,
    'Meters': 1,
    'Kilometer': 2,
    'Grams': 3,
    'Kilograms (kg)': 4,
    'Inch': 5,
    'Feet': 6,
  };
  dynamic formulas ={
    '0': [1, 0.01, 0.00001, 0, 0, 0.0328084, 0, 0, 0.035274],
    '1': [100, 1, 0.001, 0, 0, 3.28084, 0, 0, 0.00220462],
    '2': [100000, 1000, 1, 0, 0, 3280.84, 0, 0, 0.621371],
    '3': [0, 0, 0, 1, 0.001, 0, 0, 0.00220462, 0.035274],
    '4': [0, 0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '5': [0.0833333, 0.277778, 0.000254, 0, 0, 12, 0.0833333, 1, 1200],
    '6': [1, 3.28084, 0.0003048, 0, 0,144, 1, 12, 14400],
  };
  void converter (double value,String from,String to)
  {
    int? nFrom=measuresMap[from];
    int? nTo=measuresMap[to];
    var multiplier=formulas[nFrom.toString()][nTo];
    var result=value * multiplier;

    if(result==0)
    {
      errorMessage='Cannot Performed This Conversion';
    }
    else
    {
      errorMessage='${_userInput.toString()} $_startValue are ${result.toString()} $_convertedMeasure';
    }
    setState(() {
      errorMessage=errorMessage;
    });
  }
  void initState() {
    _userInput = 0;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 90),
            child: Column(
              children: [
                Text('Unit',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 50,
                    color: Colors.lightGreenAccent,
                    fontFamily: 'Merienda'
                ),),
                Text('Converter',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 50,
                      color: Colors.white,
                      fontFamily: 'Merienda'
                  ),),
                SizedBox(height: 65,),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                  child: TextField(
                    style: TextStyle(fontSize: 22,color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter Your Value',
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onChanged: (text){
                      var input=double.tryParse(text);
                      if(input!=null)
                      {
                        setState(() {
                          _userInput=input;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(height: 2),
                SizedBox(height: 35,child: Text('From',style: TextStyle(fontSize: 20,color: Colors.lightGreenAccent),)),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen.shade200,
                      borderRadius: BorderRadiusDirectional.circular(50),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text('Choose Your Unit',style: TextStyle(color: Colors.black),),
                        dropdownColor: Colors.lightGreen.shade300,
                        isExpanded: true,style: TextStyle(
                          fontSize: 20,color: Colors.black
                      ),   items: fromUnits.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),);
                      } ).toList(),
                        onChanged: (value){
                          setState(() {
                            _startValue=value!;
                          });
                        },
                        value: _startValue,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2),
                SizedBox(height: 35,child: Text('To',style: TextStyle(fontSize: 20,color: Colors.lightGreenAccent),)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen.shade200,
                      borderRadius: BorderRadiusDirectional.circular(50),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(

                        hint: Text('Choose Your Unit',style: TextStyle(color: Colors.black),),

                        dropdownColor: Colors.lightGreen.shade300,
                        isExpanded: true,style: TextStyle(
                          fontSize: 20,color: Colors.black
                      ),   items: fromUnits.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),);
                      } ).toList(),
                        onChanged: (value){
                          setState(() {
                            _convertedMeasure=value!;
                          });
                        },
                        value: _convertedMeasure,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextButton(
                    onPressed: (){
                      if(_startValue!.isEmpty || _convertedMeasure!.isEmpty || _userInput==0)
                        return;
                      else {
                        converter(_userInput, _startValue!, _convertedMeasure!);
                      }
                    },
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen.shade500,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Convert',style: TextStyle(fontSize: 30,color: Colors.black),),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text((errorMessage==null)?'':errorMessage!,
                  style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.lightGreenAccent),)
              ],
            ),
          ),
        ),
      ),);
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('_userInput', _userInput));
    properties.add(StringProperty('errorMessage', errorMessage));
  }
}