import 'package:calculator/stack.dart';

class Process {
  static int precedence(String ch) {
    if (ch == "+" || ch == "-")
      return 1;
    else if (ch == "*" || ch == "/")
      return 2;
    else
      return 0;
  }

  static double applyOp(double a, double b, String ch) {
    if (ch == "+") {
      return a + b;
    } else if (ch == "-") {
      return a - b;
    } else if (ch == "/") {
      return a / b;
    } else if (ch == "*") {
      return a * b;
    }
  }

  static bool isDigit(String ch) => double.tryParse(ch) != null;

  static int i;
  static double result = 0;
  static Stack<double> digit = Stack<double>();
  static Stack<String> ops = Stack<String>();

  static clear() {
    i = 0;
    digit.clear();
    ops.clear();
  }

  static double getResult(String exp) {
    if (isValidExp(exp)) {
      return evaluate(exp);
    } else {
      int j = exp.length - 1;
      for (j; !Process.isValidExp(exp.substring(0, j)); j--);
      return Process.evaluate(exp.substring(0, j));
    }
  }

  static double evaluate(String exp) {
    clear();
    for (i = 0; i < exp.length; i++) {
      if (exp[i] == '') {
        continue;
      } else if (exp[i] == "(") {
        ops.push(exp[i]);
      } else if (isDigit(exp[i])) {
        double val = double.parse(exp[i]);
        while (i + 1 < exp.length && isDigit(exp[i + 1])) {
          val = (val * 10) + double.parse(exp[++i]);
        }
        digit.push(val);
      } else if (exp[i] == ")") {
        while (!ops.isEmpty && ops.peek() != "(") {
          double val2 = digit.pop();
          double val1 = digit.pop();
          String ch = ops.pop();
          digit.push(applyOp(val1, val2, ch));
        }
        if (!ops.isEmpty) ops.pop();
      } else {
        while (!ops.isEmpty && precedence(ops.peek()) >= precedence(exp[i])) {
          double val2 = digit.pop();
          double val1 = digit.pop();
          String ch = ops.pop();
          digit.push(applyOp(val1, val2, ch));
        }
        ops.push(exp[i]);
      }
    }
    while (!ops.isEmpty && digit.hasAtLestTwoElements()) {
      double val2 = digit.pop();
      double val1 = digit.pop();
      String ch = ops.pop();
      digit.push(applyOp(val1, val2, ch));
      print("$val2 $val1 $ch");
    }
    return digit.pop();
  }

  static bool isValidExp(String exp) {
    int i;
    Stack<double> digit = Stack<double>();
    Stack<String> ops = Stack<String>();

    for (i = 0; i < exp.length; i++) {
      if (exp[i] == '') {
        continue;
      } else if (exp[i] == "(") {
        ops.push(exp[i]);
      } else if (isDigit(exp[i])) {
        double val = double.parse(exp[i]);
        while (i + 1 < exp.length && isDigit(exp[i + 1])) {
          val = (val * 10) + double.parse(exp[++i]);
        }
        digit.push(val);
      } else if (exp[i] == ")") {
        while (!ops.isEmpty && ops.peek() != "(") {
          double val2 = digit.pop();
          double val1 = digit.pop();
          String ch = ops.pop();
          digit.push(applyOp(val1, val2, ch));
        }
        ops.pop();
      } else {
        ops.push(exp[i]);
      }
    }
    return digit.size > ops.size;
  }
}
