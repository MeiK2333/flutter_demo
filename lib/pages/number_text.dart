import 'package:flutter/material.dart';

class NumberTextController {
  void Function(String) setValue;
}

class NumberText extends StatefulWidget {
  final NumberTextController controller;

  NumberText({this.controller});

  @override
  _NumberText createState() => _NumberText(controller);
}

class _NumberText extends State<NumberText> {
  String value = "0.0";

  _NumberText(NumberTextController _controller) {
    _controller.setValue = setValue;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$value",
            style: TextStyle(
              color: Color(0xffb85855),
              fontSize: 22,
            ),
          ),
          // TextSpan(
          //   text: ".",
          //   style: TextStyle(
          //     color: Color(0xffb85855),
          //     fontSize: 18,
          //   ),
          // ),
          // // TODO
          // TextSpan(
          //   text: "0",
          //   style: TextStyle(
          //     color: Color(0xffb85855),
          //     fontSize: 18,
          //   ),
          // ),
        ],
      ),
    );
  }

  setValue(String newValue) {
    setState(() {
      value = newValue;
    });
  }
}

// TODO: 创建状态机，管理输入
