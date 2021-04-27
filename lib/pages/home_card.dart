import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_card_item.dart';

class MyHomeCard extends StatefulWidget {
  final DateTime date;

  const MyHomeCard(this.date);

  @override
  _MyHomeCard createState() => _MyHomeCard();
}

class _MyHomeCard extends State<MyHomeCard> {
  final rng = new Random();

  dateFmt() {
    final dayOfWeek = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    var day = widget.date.day;
    var dayFmt = dayOfWeek[widget.date.weekday - 1];
    var now = DateTime.now();
    if (day == now.day) {
      dayFmt = '今天';
    } else if (day == now.day - 1) {
      dayFmt = '昨天';
    } else if (day == now.day - 2) {
      dayFmt = '前天';
    }
    return "${widget.date.month.toString().padLeft(2, '0')}.${widget.date.day.toString().padLeft(2, '0')} $dayFmt";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
        color: Color(0xff191919),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 14, right: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dateFmt(),
                    style: TextStyle(
                      color: Color(0xffbdbdbd),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "支: 888.88",
                    style: TextStyle(
                      color: Color(0xffbdbdbd),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            MyHomeCardItem("三餐", rng.nextInt(100) + rng.nextDouble()),
          ],
        ),
      ),
    );
  }
}
