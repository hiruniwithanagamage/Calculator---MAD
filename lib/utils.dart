// Hiruni Withanagamge
// IM/2021/082
// lib/utils.dart

// Utility function to check for decimal point formatting
String checkDecimal(dynamic result) {
  String decimalResult = result.toString();
  if (decimalResult.contains('.')) {
    List<String> splitDecimal = decimalResult.split('.');
    String decimalPart = splitDecimal[1];
    // check if the decimal part is zero
    if (int.parse(decimalPart) == 0) {
      return splitDecimal[0];
    }
    // Round off the result to 10 decimal places
    double roundedResult = double.parse(decimalResult);
    String roundedStr = roundedResult.toStringAsFixed(10);
    // Remove trailing zeros
    roundedStr = roundedStr.replaceAll(RegExp(r'0*$'), '');
    // Remove trailing decimal point if no decimal part remains
    if (roundedStr.endsWith('.')) {
      roundedStr = roundedStr.substring(0, roundedStr.length - 1);
    }
    return roundedStr;
  }
  return decimalResult;
}

// Function to evaluate the expression
String checkExpression(String expression) {
  List<String> tokens = expression.split(' ');
  List<double> values = []; // array for numbers
  List<String> operators = []; // array for operators

  for (String token in tokens) {
    if (token.isEmpty) continue;

    // check if the token is a number
    if (double.tryParse(token) != null) {
      values.add(double.parse(token));
    } else if (token == '(') {
      operators.add(token);
    } else if (token == ')') {
      while (operators.isNotEmpty && operators.last != '(') {
        values.add(calculateOpt(
            operators.removeLast(), values.removeLast(), values.removeLast()));
      }
      operators.removeLast();
    } else if (['+', '-', 'x', '/', '%'].contains(token)) {
      // check the precedence of the current operator
      while (operators.isNotEmpty && hasPrecedence(token, operators.last)) {
        values.add(calculateOpt(
            operators.removeLast(), values.removeLast(), values.removeLast()));
      }
      // add the current operator to the stack
      operators.add(token);
    }
  }

  while (operators.isNotEmpty) {
    values.add(calculateOpt(
        operators.removeLast(), values.removeLast(), values.removeLast()));
  }

  // handle invalid expression
  if (values.length < operators.length) {
    return 'Error';
  }

  // handle NaN
  if (values.last.isNaN) {
    return "Can't divide by zero";
  }

  // handle infinity
  if (values.last.isInfinite) {
    return "Error";
  }

  return values.last.toString();
}

// Check the operator precedence
bool hasPrecedence(String op1, String op2) {
  if (op2 == '(' || op2 == ')') return false;
  if ((op1 == 'x' || op1 == '/' || op1 == '%') &&
      (op2 == '+' || op2 == '-')) {
    return false;
  }
  return true;
}

// to perform the calculation between two operands
double calculateOpt(String operator, double b, double a) {
  if (operator == '+') {
    return a + b;
  } else if (operator == '-') {
    return a - b;
  } else if (operator == 'x') {
    return a * b;
  } else if (operator == '/') {
    return a / b;
  } else if (operator == '%') {
    return a % b;
  } else {
    throw Exception("Invalid operator");
  }
}
// Hiruni Withanagamge
// IM/2021/082
