// Hiruni Withanagamge
// IM/2021/082
// lib/buttons.dart
import 'package:flutter/material.dart';

class ButtonsWidget extends StatelessWidget {
  final Function calculation;

  ButtonsWidget({required this.calculation});

  // Create a common button widget
  Widget calButton(String btnText, Color btnColor, Color textColor) {
    return Container(
      height: 70,
      width: 80,
      child: ElevatedButton(
        onPressed: () => calculation(btnText),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: btnColor.withOpacity(0.2),
          padding: EdgeInsets.all(20),
        ),
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 22,
            color: textColor,
          ),
        ),
      ),
    );
  }

  // Create calculator buttons with higher opacity (for = button)
  Widget calButton2(String btntext, Color btncolor, Color textColor) {
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            calButton("AC", Colors.grey, Colors.red),
            calButton("√", Colors.grey, Colors.blue),
            calButton("%", Colors.grey, Colors.blue),
            calButton("/", Colors.grey, Colors.blue),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            calButton("7", Colors.grey, Colors.white),
            calButton("8", Colors.grey, Colors.white),
            calButton("9", Colors.grey, Colors.white),
            calButton("x", Colors.grey, Colors.blue),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            calButton("4", Colors.grey, Colors.white),
            calButton("5", Colors.grey, Colors.white),
            calButton("6", Colors.grey, Colors.white),
            calButton("-", Colors.grey, Colors.blue),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            calButton("1", Colors.grey, Colors.white),
            calButton("2", Colors.grey, Colors.white),
            calButton("3", Colors.grey, Colors.white),
            calButton("+", Colors.grey, Colors.blue),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            calButton("0", Colors.grey, Colors.white),
            calButton("+/-", Colors.grey, Colors.white),
            calButton(".", Colors.grey, Colors.white),
            calButton2("=", Colors.blue, Colors.white),
          ],
        )
      ],
    );
  }
}
// Hiruni Withanagamge
// IM/2021/082
