import 'package:flutter/material.dart';

class Booking extends StatelessWidget {
  final DateTime date;

  const Booking({this.date});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xff111111),
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: TabBar(
            labelStyle: TextStyle(fontSize: 18, color: Color(0xfbcbcbc)),
            unselectedLabelStyle:
                TextStyle(fontSize: 18, color: Color(0xff7f7f7f)),
            isScrollable: true,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 2,
                color: Color(0xFF5b5b5b),
              ),
            ),
            tabs: [
              Tab(
                text: "支出",
              ),
              Tab(
                text: "收入",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // TODO
            Text("${date.day}", style: TextStyle(color: Colors.white),),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}
