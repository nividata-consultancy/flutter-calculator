import 'package:calculator/src/utility/stack.dart';

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

  static bool isDigit(String ch) =>
      ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"].contains(ch);

  static bool isFiniteDouble(double ch) => ch % 1 == 0;

  static bool isOperand(String ch) => ["+", "-", "*", "/"].contains(ch);

  static bool isParentheses(String ch) => ["(", ")"].contains(ch);

  static bool isOpenParentheses(String ch) => ch == "(";

  static bool isCloseParentheses(String ch) => ch == ")";

  static int i;
  static double result = 0;
  static Stack<double> digit = Stack<double>();
  static Stack<String> ops = Stack<String>();
  static Stack<String> parentheses = Stack<String>();

  static clear() {
    i = 0;
    digit.clear();
    ops.clear();
  }

  static String getResult(String exp) {
    if (isValidExp(exp)) {
      double x = evaluate(exp);
      if (isFiniteDouble(x))
        return x.toInt().toString();
      else
        return x.toString();
    } else {
      int j = exp.length - 1;
      for (j; (0 < j && !Process.isValidExp(exp.substring(0, j))); j--);
      double x = Process.evaluate(exp.substring(0, j));
      if (isFiniteDouble(x))
        return x.toInt().toString();
      else
        return x.toString();
    }
  }

  static String infixToPostfix(String exp) {
    String result = "";
    for (int i = 0; i < exp.length; ++i) {
      String x = exp[i];
      if (isDigit(x)) {
        result += x;
      } else if (x == "(") {
        parentheses.push(x);
      } else if (x == ")") {
        while (!parentheses.isEmpty && parentheses.peek() != "(") {
          result += parentheses.pop();
        }
        if (!parentheses.isEmpty && parentheses.peek() != "(")
          return "null";
        else
          parentheses.pop();
      } else {
        while (!parentheses.isEmpty &&
            precedence(x) <= precedence(parentheses.peek())) {
          if (parentheses.peek() == "(") return "null1";
          result += parentheses.pop();
        }
        parentheses.push(x);
      }
    }
    while (!parentheses.isEmpty) {
      if (parentheses.peek() == "(") return "null3";
      result += parentheses.pop();
    }
    return result;
  }

  static double evaluate(String exp) {
    clear();
    if (exp.isEmpty) return 0;

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
      } else if (exp[i] == ".") {
        String val = "0.";
        while (i + 1 < exp.length && Process.isDigit(exp[i + 1])) {
          val = val + exp[i + 1];
          i++;
        }
        if (digit.peek() != 0) {
          digit.push(double.tryParse(val) * digit.pop());
        } else {
          digit.pop();
          digit.push(double.tryParse(val));
        }
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
    }
    return digit.pop();
  }

  static bool isValidExp(String exp) {
    int i;
    Stack<double> digit = Stack<double>();
    Stack<String> ops = Stack<String>();

    for (i = 0; i < exp.length; i++) {
      if (exp[i] == "(") {
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

  static void addParentheses() {
    parentheses.push("(");
  }
}
