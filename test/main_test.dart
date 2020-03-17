import 'package:calculator/src/utility/Process.dart';
import 'package:test/test.dart';

void main() {
  group("test", () {
    test("test 1", () {
      String exp = "5";
      String result = Process.getResult(exp);
      expect(result, equals("5"));
    });

    test("test 2", () {
      String exp = "5+";
      String result = Process.getResult(exp);
      expect(result, equals("5"));
    });

    test("test 3", () {
      String exp = "5+5";
      String result = Process.getResult(exp);
      expect(result, equals("10"));
    });

    test("test 3", () {
      String exp = "(5+5";
      String result = Process.getResult(exp);
      expect(result, equals("10"));
    });

  });
}
