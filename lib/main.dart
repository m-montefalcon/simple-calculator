import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(const FinalFlutter());
}

class FinalFlutter extends StatelessWidget {
  const FinalFlutter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: "Simple Calculator",
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const SimpleCalculator(),
    );
  }
}
class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

String preTemp = "0";
String res = "0";
String operation = "0";
double  preTempFontSize = 38.0;
double  resFontSize = 58.0;
List operator = [];



  buttonPressed(String buttonText){
    setState(() {

      if(buttonText == "C"){
        preTemp = "0";
        res = "0";
      }else if (buttonText == "⌫"){
        preTemp = preTemp.substring(0, preTemp.length-1);
      }

      else if (buttonText == "="){
        res = preTemp;

        preTemp = preTemp.replaceAll('×', '*');
        preTemp = preTemp.replaceAll('÷', '/');

      try{
        Parser p = Parser();

        Expression exp = p.parse(preTemp);
        ContextModel cm = ContextModel();
        res = '${exp.evaluate(EvaluationType.REAL, cm)}';


      }catch(e){
        res = "ERROR";
      }





      }else{
        if(preTemp == "0"){
          preTemp = buttonText;
        }else{
          preTemp = preTemp + buttonText;
        }
      }

    });

  }
  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
        height: MediaQuery.of(context).size.height *0.1* buttonHeight,
        color: buttonColor,
        child: TextButton(
          onPressed: () => buttonPressed(buttonText),
          style: TextButton.styleFrom(
            primary: Colors.black87,
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24),

          ),

        )
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar (title: const Text("Simple Calculator")),
      body: Column(
        children: <Widget>[

          Container(
            alignment: Alignment.centerRight,
            padding : const EdgeInsets.fromLTRB(10, 30, 10 , 0),
            child:  Text(preTemp, style: TextStyle(fontSize: preTempFontSize),),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding : const EdgeInsets.fromLTRB(10, 30, 10 , 0),
        child:  Text(res, style: TextStyle(fontSize: resFontSize),),
      ),
          const Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.redAccent),
                        buildButton("⌫", 1, Colors.redAccent),
                        buildButton("÷", 1, Colors.blueAccent),

                      ]

                    ),
                    TableRow(
                        children: [
                          buildButton("7", 1, Colors.black38),
                          buildButton("8", 1, Colors.black38),
                          buildButton("9", 1, Colors.black38),

                        ]

                    ),
                    TableRow(
                        children: [
                          buildButton("4", 1, Colors.black38),
                          buildButton("5", 1, Colors.black38),
                          buildButton("6", 1, Colors.black38),

                        ]

                    ),
                    TableRow(
                        children: [
                          buildButton("1", 1, Colors.black38),
                          buildButton("2", 1, Colors.black38),
                          buildButton("3", 1, Colors.black38),

                        ]

                    ),
                    TableRow(
                        children: [
                          buildButton(".", 1, Colors.black38),
                          buildButton("0", 1, Colors.black38),
                          buildButton("00", 1, Colors.black38),

                        ]

                    ),

                  ],
                )

              ),
              Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                   TableRow(
                     children: [
                       buildButton("×", 1, Colors.blueAccent),
                     ]
                   ),
                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.blueAccent),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.blueAccent),


                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("=", 2, Colors.blueAccent),
                        ]
                    ),


                  ]
                )
              )

            ],
          )
        ],
      ),

    );
  }
}

