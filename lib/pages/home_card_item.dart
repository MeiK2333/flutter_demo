import 'package:flutter/material.dart';
import 'package:flutter_app/data/bill.dart';

class MyHomeCardItem extends StatefulWidget {
  final BillItem bill;

  const MyHomeCardItem(this.bill);

  @override
  _MyHomeCardItem createState() => _MyHomeCardItem();
}

class _MyHomeCardItem extends State<MyHomeCardItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: 修改
        print('edit ${widget.bill.name}');
      },
      focusColor: Color(0xff171717),
      highlightColor: Color(0xff171717),
      hoverColor: Color(0xff171717),
      splashColor: Color(0xff171717),
      child: Padding(
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
                    text: widget.bill.name,
                    style: TextStyle(
                      color: Color(0xffbdbdbd),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "-${widget.bill.amount.toStringAsFixed(2)}",
              style: TextStyle(
                color: Color(0xffb85855),
                fontSize: 14,
              ),
            ),
            // TODO: 备注
          ],
        ),
      ),
    );
  }
}
