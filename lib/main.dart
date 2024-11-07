import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        output = "0"; //logika pertama if=jika
      } else if (buttonText == "=") {
        try {
          //jika tidak error yang terbaca try
          output = evaluateExpression(output);
        } catch (e) {
          //jika error yang terbaca catch (karena yang dimasukkan - + / x, selain itu akan error)
          output = "Error";
        }
      } else {
        if (output == "0")
          output = buttonText; //berati jika belum dipencet keluarnya dioutput angka 0
        else {
          output += buttonText; //berati jika sudah dipencet angka lain akan menghasilkan 
        }
      }
    });
  }

  String evaluateExpression(String expression) {
    final parsedExpression = Expression.parse(
        expression); //merubah string/teks menjadi interger/bilangan
    final evaluator = ExpressionEvaluator(); //menghitung-> + - / *
    final result =
        evaluator.eval(parsedExpression, {}); //menyimpan hasil perhitungan

    return result.toString();
  }

  Widget buildButton(String buttonText, Color color,
      {double widhtFactor = 1.0}) {
    return Expanded(
      flex: widhtFactor.toInt(),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 22),
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
              elevation: 0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 24.0, bottom: 24.0),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: TextStyle(
                  fontSize: 80,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("C", Colors.grey.shade600),
                  buildButton("&", Colors.grey.shade600),
                  buildButton("%", Colors.grey.shade600),
                  buildButton("/", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("7", Colors.grey.shade800),
                  buildButton("8", Colors.grey.shade800),
                  buildButton("9", Colors.grey.shade800),
                  buildButton("*", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("4", Colors.grey.shade800),
                  buildButton("5", Colors.grey.shade800),
                  buildButton("6", Colors.grey.shade800),
                  buildButton("-", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("1", Colors.grey.shade800),
                  buildButton("2", Colors.grey.shade800),
                  buildButton("3", Colors.grey.shade800),
                  buildButton("+", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("0", Colors.grey.shade800, widhtFactor: 2.0),
                  buildButton(".", Colors.grey.shade800),
                  buildButton("=", Colors.orange),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
