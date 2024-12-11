// Hiruni Withanagamge
// IM/2021/082
// lib/calculator.dart
import 'package:flutter/material.dart';
import 'buttons.dart';
import 'utils.dart';
import 'dart:math';

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic resultText = '';
  dynamic previousEquation = '';
  dynamic currentInput = '';
  dynamic opr = '';
  dynamic preOpr = '';
  bool isOpenBracket = true;
  int i = 0;
  bool lastPressedBtn = false;

  // Calculation function
  void calculation(String btnText) {
    if (btnText == 'AC') {
      resultText = '';
      previousEquation = '';
      currentInput = '';
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
      resultText = checkDecimal(checkExpression(currentInput));
      currentInput = '';
      lastPressedBtn = true;
    } else if (btnText == '√') {
      // to handle the square root
      if (currentInput.isNotEmpty) {
        double number = double.parse(currentInput);

        // to avoid negative square roots
        if (number < 0) {
          resultText = "Invalid";
        } else {
          previousEquation = btnText+currentInput;
          double sqrtResult = (number >= 0) ? sqrt(number) : 0;
          currentInput = checkDecimal(sqrtResult);
          resultText = currentInput;
          currentInput = '';
        }
      }
    } else if (btnText == '%'){
      // to avoid append new input to previous results
      if (currentInput.isEmpty && resultText.isNotEmpty){
        currentInput = resultText;
      }
      // to avoid multiple percentage signs
      if (currentInput.isNotEmpty) {
        if(i >= 1){
          resultText = "Invalid format used";
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
        List<String> tokens = currentInput.split(' ');
        String lastToken = tokens.last;

        if (double.tryParse(lastToken) != null) {
          // to change the sign of the last number
          if (lastToken.startsWith('-')) {
            tokens[tokens.length - 1] = lastToken.substring(1);
          } else {
            // to add the negative sign
            tokens[tokens.length - 1] = '-' + lastToken;
          }
          currentInput = tokens.join(' ');
          resultText = currentInput;
        }
      }
    }else if (btnText == '.') {
      List<String> tokens = currentInput.split(' ');
      String lastToken = tokens.isNotEmpty ? tokens.last : '';

      // to avoid multiple decimal points
      if (!lastToken.contains('.')) {
        if (lastToken.isEmpty) {
          currentInput += '0.';
        } else {
          currentInput += btnText;
        }
      }
      resultText = currentInput;
    } else {
      // to avoid append new input if currentInput/resultText is empty
      if (currentInput.isEmpty && ['+', '-', 'x', '/', '%'].contains(btnText.trim().split(' ').last) && resultText.isEmpty)  {
        // do nothing
        // to avoid multiple operators
      }else if (['+', '-', 'x', '/', '%'].contains(btnText)) {
        // to avoid operator if already at the end
        // if (currentInput.isEmpty && ['+', '-', 'x', '/', '%'].contains(btnText.trim().split(' ').last)) {
        // do nothing
        // }
        if (currentInput.isEmpty || currentInput == 'Error') {
          currentInput = resultText + ' $btnText ';
          // to avoid multiple operators
        } else if (!['+', '-', 'x', '/', '%'].contains(currentInput.trim().split(' ').last)) {
          currentInput += ' $btnText ';
        }
      } else {
        if (currentInput == 'Error') {
          currentInput = btnText;
        } else if (currentInput == '0') {
          currentInput = btnText; // Replace leading zero with the new number
        } else {
          currentInput += btnText;
        }
      }
      resultText = currentInput;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Calculator", style: TextStyle(fontSize: 25)),
        centerTitle: true,
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
                          overflow: TextOverflow.ellipsis,
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
            ButtonsWidget(calculation: calculation)
          ],
        ),
      ),
    );
  }
}
// Hiruni Withanagamge
// IM/2021/082
