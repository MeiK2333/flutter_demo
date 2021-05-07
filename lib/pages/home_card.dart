import 'package:flutter/material.dart';
import 'package:flutter_app/data/bill.dart';
import 'package:flutter_app/pages/booking.dart';
import 'package:flutter_app/pages/home_card_item.dart';
import 'package:flutter_app/utils.dart';

class MyHomeCard extends StatefulWidget {
  final MapEntry<String, List<BillItem>> data;

  const MyHomeCard(this.data);

  @override
  _MyHomeCard createState() => _MyHomeCard();
}

class _MyHomeCard extends State<MyHomeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
        color: Color(0xff191919),
        child: Column(
          children: <Widget>[
                InkWell(
                  onTap: () {
                    // 指定日期记账
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Booking(date: widget.data.value[0].date)),
                    );
                  },
                  focusColor: Color(0xff171717),
                  highlightColor: Color(0xff171717),
                  hoverColor: Color(0xff171717),
                  splashColor: Color(0xff171717),
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 8, bottom: 8, left: 14, right: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.data.value[0].dateFmt(),
                          style: TextStyle(
                            color: Color(0xffbdbdbd),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "支: ${Utils.billsAmountSum(widget.data.value)}",
                          style: TextStyle(
                            color: Color(0xffbdbdbd),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] +
              widget.data.value.map<Widget>((e) => MyHomeCardItem(e)).toList(),
        ),
      ),
    );
  }
}
