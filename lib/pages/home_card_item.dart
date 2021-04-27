import 'package:flutter/material.dart';

class MyHomeCardItem extends StatefulWidget {
  final String name;
  final double amount;

  const MyHomeCardItem(this.name, this.amount);

  @override
  _MyHomeCardItem createState() => _MyHomeCardItem();
}

class _MyHomeCardItem extends State<MyHomeCardItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 14, right: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "•   ",
                  style: TextStyle(
                    color: Color(0xffb85855),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: widget.name,
                  style: TextStyle(
                    color: Color(0xffbdbdbd),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "-${widget.amount.toStringAsFixed(2)}",
            style: TextStyle(
              color: Color(0xffb85855),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
