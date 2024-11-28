import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(), // Set the starting screen of the app
    );
  }
}

// stateful to allow for dynamic changes
class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _State();
}

// all the logic and state of the calculator
class _State extends State<Calculator> {
  // define variables
  dynamic resultText = ''; // Display resultText
  dynamic previousEquation = ''; // last evaluated expression
  dynamic currentInput = ''; // Current entered input
  double numOne = 0; // First number
  double numTwo = 0; // Second number
  dynamic result = ''; // intermediate calculation result
  dynamic finalResult = ''; // Final result to display
  dynamic opr = ''; // Current operator
  dynamic preOpr = ''; // Previous operator
  bool isOpenBracket = true; // Check whether the bracket is open
  int i = 0; // Check if the percentage button is clicked
  bool lastPressedBtn = false;

  // Create calculator buttons (default opacity)
  Widget calbutton(String btntext, Color btncolor, Color textColor) {
    return Container(
      height: 70,
      width: 80,
      child: ElevatedButton(
        onPressed: () {
          if( lastPressedBtn && btntext != '=' ){
            currentInput = '';
            previousEquation = currentInput;
            lastPressedBtn = false;
          }
          if (btntext == '0' && currentInput == '0'){
            // do nothing
          }else{
            calculation(btntext);
          }
        },
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: btncolor.withOpacity(0.2),
          padding: EdgeInsets.all(20),
        ),
        child: Text(
          btntext,
          style: TextStyle(
            fontSize: 22,
            color: textColor,
          ),
        ),
      ),
    );
  }

  // Create calculator buttons with higher opacity (for = button)
  Widget calbutton2(String btntext, Color btncolor, Color textColor) {
    return Container(
      height: 70,
      width: 80,
      child: ElevatedButton(
        onPressed: () {
          calculation(btntext);
        },
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: btncolor.withOpacity(0.4),
          padding: EdgeInsets.all(20),
        ),
        child: Text(
          btntext,
          style: TextStyle(
            fontSize: 22,
            color: textColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // provide the structure(UI)
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Calculator", style: TextStyle(fontSize: 25)),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Display area for the previous equation and current input/result
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          previousEquation,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          resultText,
                          // check if the number is too long
                          overflow: TextOverflow.ellipsis,
                          // currentInput.length > 15 ? "Number is too long" : currentInput,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // to delete the last character
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: IconButton(
                    onPressed: () {
                      calculation('⌫');
                    },
                    icon: Icon(
                      Icons.backspace,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),

            // Calculator buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton("AC", Colors.grey, Colors.red),
                calbutton("\u221A", Colors.grey, Colors.blue),
                calbutton("%", Colors.grey, Colors.blue),
                calbutton("/", Colors.grey, Colors.blue),
              ],
            ),
            SizedBox(height: 10), // to add space between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton("7", Colors.grey, Colors.white),
                calbutton("8", Colors.grey, Colors.white),
                calbutton("9", Colors.grey, Colors.white),
                calbutton("x", Colors.grey, Colors.blue),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton("4", Colors.grey, Colors.white),
                calbutton("5", Colors.grey, Colors.white),
                calbutton("6", Colors.grey, Colors.white),
                calbutton("-", Colors.grey, Colors.blue),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton("1", Colors.grey, Colors.white),
                calbutton("2", Colors.grey, Colors.white),
                calbutton("3", Colors.grey, Colors.white),
                calbutton("+", Colors.grey, Colors.blue),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton("0", Colors.grey, Colors.white),
                calbutton("+/-", Colors.grey, Colors.white),
                calbutton(".", Colors.grey, Colors.white),
                calbutton2("=", Colors.blue, Colors.white),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Function to calculate the result and handle button clicks
  void calculation(String btnText) {
    if (btnText == 'AC') {
      resultText = '';
      previousEquation = '';
      currentInput = '';
      numOne = 0;
      numTwo = 0;
      // result = '';
      // finalResult = '0';
      opr = '';
      preOpr = '';
      isOpenBracket = true;
      i = 0;
    } else if (btnText == '⌫') {
      if (currentInput.isNotEmpty) {
        currentInput = currentInput.substring(0, currentInput.length - 1);
        resultText = currentInput;
      }
    } else if (btnText == '=') {
      previousEquation = resultText;
      resultText = doesContainDecimal(evaluateExpression(currentInput));
      currentInput = '';
      lastPressedBtn = true;
    } else if (btnText == '%'){
      if (currentInput.isEmpty && resultText.isNotEmpty){
        currentInput = resultText;
      }
      if (currentInput.isNotEmpty) {
        if(i >= 1){
          resultText = "Invalid";
        }else{
          i += 1;
          previousEquation = currentInput+btnText;
          double number = double.parse(currentInput);
          double percentage = number / 100;
          currentInput = percentage.toString();
          resultText = currentInput;
          currentInput = '';
        }
      }
    } else if (btnText == '+/-') {
      if (currentInput.isNotEmpty) {
        if (currentInput.startsWith('-')) {
          currentInput = currentInput.substring(1);
        } else {
          currentInput = '-' + currentInput;
        }
        resultText = currentInput;
        currentInput = '';
      }
    }else if (btnText == '.') {
      if (!currentInput.contains('.')) {
        if (currentInput.isEmpty) {
          currentInput = '0.';
        } else {
          currentInput += btnText;
        }
      }
      resultText = currentInput;
    } else if (btnText == '\u221A') {
      // Handle square root functionality
      if (currentInput.isNotEmpty) {
        double number = double.parse(currentInput);
        if (number < 0) {
          resultText = "Invalid";  // Handle negative numbers in square root
        } else {
          previousEquation = btnText+currentInput;
          double sqrtResult = (number >= 0) ? sqrt(number) : 0;
          currentInput = doesContainDecimal(sqrtResult);
          resultText = currentInput;
          currentInput = '';
        }
      }
    }else {
      if (currentInput.isEmpty && ['+', '-', 'x', '/', '%'].contains(btnText.trim().split(' ').last) && resultText.isEmpty)  {
        // do nothing
      }else if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '%') {
        if (currentInput.isEmpty && ['+', '-', 'x', '/', '%'].contains(btnText.trim().split(' ').last)) {
          // do nothing
        }
        if (currentInput.isEmpty || currentInput == 'Error') {
          currentInput = resultText + ' $btnText ';
        } else if (!['+', '-', 'x', '/', '%'].contains(currentInput.trim().split(' ').last)) {
          currentInput += ' $btnText ';
        }
      } else {
        if (currentInput == 'Error') {
          currentInput = btnText;
        } else {
          currentInput += btnText;
        }
      }
      resultText = currentInput;
    }
    setState(() {});
  }

  // Function to evaluate the expression
  String evaluateExpression(String expression) {
    List<String> tokens = expression.split(' ');
    List<double> values = []; //stack for numbers
    List<String> ops = []; //stack for operators

    for (String token in tokens) {
      if (token.isEmpty) continue;

      // check if the token is a number
      if (double.tryParse(token) != null) {
        values.add(double.parse(token));
      } else if (token == '(') {
        ops.add(token);
      } else if (token == ')') {
        while (ops.isNotEmpty && ops.last != '(') {
          values.add(applyOp(
              ops.removeLast(), values.removeLast(), values.removeLast()));
        }
        ops.removeLast();
      } else if (token == '+' || token == '-' || token == 'x' || token == '/' ||
          token == '%') {
        // check the precedence of the current operator
        while (ops.isNotEmpty && hasPrecedence(token, ops.last)) {
          values.add(applyOp(
              ops.removeLast(), values.removeLast(), values.removeLast()));
        }
        // add the current operator to the stack
        ops.add(token);
      }
    }

    // apply the remaining operators
    while (ops.isNotEmpty) {
      values.add(applyOp(
          ops.removeLast(), values.removeLast(), values.removeLast()));
    }

    // if the valuelast is NaN
    if (values.last.isNaN) {
      return "Can't divide by zero";
    }

    // if the valuelast is infinite
    if (values.last.isInfinite) {
      return 'Error';
    }

    return values.last.toString();
  }

  // Function to check the precedence of operators
  bool hasPrecedence(String op1, String op2) {
    if (op2 == '(' || op2 == ')') return false;
    if ((op1 == 'x' || op1 == '/' || op1 == '%') && (op2 == '+' || op2 == '-'))
      return false;
    return true;
  }

  // Function to apply the operator
  double applyOp(String op, double b, double a) {
    switch (op) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case 'x':
        return a * b;
      case '/':
        return a / b;
      case '%':
        return (a * (b / 100));
      default:
        return 0;
    }
  }

  // Function to check if the result contains a decimal
  String doesContainDecimal(dynamic result) {
    String resultStr = result.toString();
    if (resultStr.contains('.')) {
      List<String> splitDecimal = resultStr.split('.');
      String decimalPart = splitDecimal[1];
      if (int.parse(decimalPart) == 0) {
        return splitDecimal[0];
      }
      // Round off the result to 10 decimal places
      double roundedResult = double.parse(resultStr);
      String roundedStr = roundedResult.toStringAsFixed(10);
      // Remove trailing zeros
      roundedStr = roundedStr.replaceAll(RegExp(r'0*$'), '');
      // Remove trailing decimal point if no decimal part remains
      if (roundedStr.endsWith('.')) {
        roundedStr = roundedStr.substring(0, roundedStr.length - 1);
      }
      return roundedStr;
    }
    return resultStr;
  }
}

