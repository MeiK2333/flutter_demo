import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_card.dart';
import 'package:flutter_app/pages/nav_drawer.dart';

class MyHomePage extends StatelessWidget {
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawerScrimColor: Color(0x70ffffff),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color(0xffbdbdbd)),
        elevation: 0.0,
        centerTitle: true,
        title: InkWell(
          child: Text(
            '${now.year}.${now.month.toString().padLeft(2,'0')}',
            style: TextStyle(color: Color(0xffbdbdbd)),
          ),
          onTap: () {},
        ),
      ),
      drawer: NavDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      body: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: now.day + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
              height: 320,
              padding: EdgeInsets.only(bottom: 8),
              child: Image(image: AssetImage('assets/home.jpg')),
            );
          }
          return MyHomeCard(now.subtract(Duration(days: index - 1)));
        },
      ),
    );
  }
}
