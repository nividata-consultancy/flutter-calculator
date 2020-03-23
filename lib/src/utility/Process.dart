import 'package:calculator/src/expressionLanguage/expression_language.dart';
import 'package:calculator/src/resources/CalculatorDataProvider.dart';
import 'package:calculator/src/utility/stack.dart';

void main() {
  String exp = "123.2";
  print(Process.isListDigitContainDot(exp));
//  String exp = "105%";
//  var x = Process.isValid2(exp);
//  var x = (ExpressionGrammarParser({}).build().parse(exp).value as Expression);

//  var x = Test.Parser()
//      .parse(exp)
//      .evaluate(Test.EvaluationType.REAL, Test.ContextModel());
//  print("${x}");`
//  print("${Process.isValid2(exp)}");
//  print("${x.evaluate()}");
//  print("${Process.getResult(exp)}");
}

class Process {
  static int i;
  static double result = 0;
  static Stack<double> digit = Stack<double>();
  static Stack<String> ops = Stack<String>();
  static Stack<String> parentheses = Stack<String>();

  static String getResult(String exp) {
    exp = exp
        .split('')
        .map((text) {
          if (text == "%")
            return text + "*";
          else
            return text;
        })
        .toList()
        .join("");
    String tempExp = exp;
    int j = exp.length;
    if (tempExp.contains("(")) {
      while ("(".allMatches(tempExp).length > ")".allMatches(tempExp).length) {
        tempExp += ")";
      }
    }

    while (!Process.isValid2(tempExp)) {
      tempExp = exp.substring(0, --j);
      if (tempExp.contains("(")) {
        while (
            "(".allMatches(tempExp).length > ")".allMatches(tempExp).length) {
          tempExp += ")";
        }
      }
    }
    /*double x = Process.evaluate(tempExp);
    if (isFiniteDouble(x))
      return x.toInt().toString();
    else
      return x.toString();*/
    return (ExpressionGrammarParser({}).build().parse(tempExp).value
            as Expression)
        .evaluate()
        .toString();
//    if (isFiniteDouble(x))
//      return x.toInt().toString();
//    else
//      return x.toString();
//    double x = evaluate(tempExp);
    /* if (isValidExp(exp)) {
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
    }*/
  }

  static bool isValid2(String exp) {
    try {
      ExpressionGrammarParser({}).build().parse(exp);
      return true;
    } catch (e, s) {
      return false;
    }
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
    while (!ops.isEmpty) {
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
      } else if (exp[i] == ")" && digit.hasAtLestTwoElements()) {
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

  static clear() {
    i = 0;
    digit.clear();
    ops.clear();
  }

  static int precedence(String ch) {
    if (ch == "+" || ch == "-")
      return 1;
    else if (ch == "*" || ch == "/")
      return 2;
    else if (ch == "%")
      return 3;
    else
      return 0;
  }

  static double applyOp(double a, double b, String ch) {
    if (ch == CalculatorDataProvider.ADD) {
      return a + b;
    } else if (ch == CalculatorDataProvider.SUBTRACT) {
      return a - b;
    } else if (ch == CalculatorDataProvider.DIVIDE) {
      return a / b;
    } else if (ch == CalculatorDataProvider.MULTIPLY) {
      return a * b;
    } else if (ch == CalculatorDataProvider.PERCENTAGE) {
      return a * b * 0.01;
    }
  }

  static bool isDigit(String ch) =>
      ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"].contains(ch);

  static bool isFiniteDouble(double ch) => ch % 1 == 0;

  static bool isOperand(String ch) => ["+", "-", "*", "/"].contains(ch);

  static bool isParentheses(String ch) => ["(", ")"].contains(ch);

  static bool isOpenParentheses(String ch) => ch == "(";

  static bool isCloseParentheses(String ch) => ch == ")";

  static bool isListDigitContainDot(String exp) {
    int j = exp.length - 1;
    while (j >= 0 && !isOperand(exp[j])) {
      if (exp[j] == ".")
        return true;
      else
        j--;
    }
    return false;
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
}
