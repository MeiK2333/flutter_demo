import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class NumberTextController {
  void Function(String) setValue;
  double Function() getValue;
}

class NumberText extends StatefulWidget {
  final NumberTextController controller;

  NumberText({this.controller});

  @override
  _NumberText createState() => _NumberText(controller);
}

class _NumberText extends State<NumberText> {
  double value = 0;
  String left = "0";
  String point = "";
  String right = "";
  NumberTextValue textValue = NumberTextValue();

  _NumberText(NumberTextController _controller) {
    _controller.setValue = setValue;
    _controller.getValue = getValue;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$left",
            style: TextStyle(
              color: Color(0xffb85855),
              fontSize: 22,
            ),
          ),
          TextSpan(
            text: "$point",
            style: TextStyle(
              color: Color(0xffb85855),
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: "$right",
            style: TextStyle(
              color: Color(0xffb85855),
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  setValue(String newValue) {
    setState(() {
      textValue.setOperator(newValue);
      value = textValue.getValue();
      var val = textValue.getString();
      var idx = val.indexOf('.');
      if (idx >= 0) {
        left = val.substring(0, idx);
        point = '.';
        right = val.substring(idx + 1);
      } else {
        left = val;
        point = '';
        right = '';
      }
    });
  }

  double getValue() {
    return value;
  }
}

enum NumberTextState {
  zero, // 当前值为 0
  num, // 当前输入数字中
  point, // .
  point1, // .1
  point2, // .12
  op, // + -
}

class _TextValueStackItem {
  String string;
  NumberTextState state;

  _TextValueStackItem(this.string, this.state);
}

class NumberTextValue {
  List<_TextValueStackItem> stack = [
    _TextValueStackItem('0', NumberTextState.zero)
  ];
  NumberTextState state = NumberTextState.zero;

  /// 0-9 的数字
  void setNum(int num) {
    var item = _TextValueStackItem(num.toString(), state);
    switch (state) {
      // 如果当前值为 0，则直接替换 0 为目标数字
      case NumberTextState.zero:
        if (num == 0) {
          return;
        } else {
          state = NumberTextState.num;
        }
        // 移除 0 的状态
        stack.removeLast();
        break;
      case NumberTextState.num:
        state = NumberTextState.num;
        break;
      case NumberTextState.op:
        if (num == 0) {
          state = NumberTextState.zero;
        } else {
          state = NumberTextState.num;
        }
        break;
      case NumberTextState.point:
        state = NumberTextState.point1;
        break;
      case NumberTextState.point1:
        state = NumberTextState.point2;
        break;
      // 小数点后最多保留两位
      case NumberTextState.point2:
        return;
      default:
        return;
    }
    stack.add(item);
  }

  /// + - . < =
  void setOperator(String operator) {
    var item = _TextValueStackItem(operator, state);
    var num = int.tryParse(operator);
    if (num != null) {
      if (stack.length >= 16) {
        return;
      }
      setNum(num);
    } else if (operator == '.') {
      switch (state) {
        // 只要前面是数字，就可以加小数点
        // 如果状态为 op 但前面不是 0，则在前面添加一个 0
        case NumberTextState.op:
          if (stack.last.string != '0') {
            stack.add(_TextValueStackItem('0', NumberTextState.zero));
          }
          state = NumberTextState.point;
          break;
        case NumberTextState.zero:
        case NumberTextState.num:
          state = NumberTextState.point;
          break;
        default:
          return;
      }
      stack.add(item);
    } else if (operator == '+' || operator == '-') {
      switch (state) {
        // 整数与小数时均可以加减法
        case NumberTextState.zero:
        case NumberTextState.num:
        case NumberTextState.point1:
        case NumberTextState.point2:
          // 触发加减法之前，计算合并前面的所有操作
          setOperator('=');
          state = NumberTextState.op;
          break;
        case NumberTextState.point:
          // 如果当前结尾为小数点，则移除小数点后做加减法
          stack.removeLast();
          setOperator('=');
          state = NumberTextState.op;
          break;
        case NumberTextState.op:
          // 如果当前为加减法，则替换之前的操作符
          stack.removeLast();
          state = NumberTextState.op;
          break;
        default:
          return;
      }
      stack.add(item);
    } else if (operator == '<') {
      // 退格
      var last = stack.removeLast();
      // 恢复状态
      state = last.state;
      // 如果删除的是最后一个值，则填充默认的 0
      if (stack.length == 0) {
        stack.add(_TextValueStackItem('0', NumberTextState.zero));
        return;
      }
    } else if (operator == '=') {
      compute();
    } else {
      return;
    }
  }

  /// 根据当前已输入的字符，计算当前的值，并替换栈内元素
  void compute() {
    double val = getValue();
    // 初始化状态
    stack = [_TextValueStackItem('0', NumberTextState.zero)];
    state = NumberTextState.zero;
    if (val <= 0) {
      // 如果计算值小于等于 0，则等于 0
      val = 0;
    } else {
      // 如果有正数的值，则替换到栈内
      val = double.parse(val.toStringAsFixed(2));
      String str = val.toString();
      // 如果结果为整数，则舍去小数点后部分
      if (val == val.ceil() * 1.0) {
        str = val.ceil().toString();
      }
      str.runes.forEach((element) {
        var character = new String.fromCharCode(element);
        setOperator(character);
      });
    }
  }

  double getValue() {
    Parser p = Parser();
    var str = getString();
    if (str.endsWith('-') || str.endsWith('+')) {
      str = str.substring(0, str.length - 1);
    }
    Expression exp = p.parse(str);
    double val = exp.evaluate(EvaluationType.REAL, null);
    return val;
  }

  String getString() {
    List<String> strList = [];
    for (var item in stack) {
      strList.add(item.string);
    }
    return strList.join();
  }
}
