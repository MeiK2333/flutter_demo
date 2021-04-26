import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
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
        title: Text('2021.04', style: TextStyle(color: Color(0xffbdbdbd))),
      ),
      drawer: NavDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      body: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
              height: 320,
              padding: EdgeInsets.only(bottom: 8),
              child: Image(image: AssetImage('assets/home.jpg')),
            );
          }
          return Container(
            color: Colors.black,
            height: 100,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
              color: Color(0xff191919),
              child: Text(
                '$index',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Ink(
        color: Color(0xff1a1a1a),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.verified_user),
              title: Text(
                '我的账本',
                style: TextStyle(color: Color(0xffbdbdbd)),
              ),
              onTap: () => {Navigator.of(context).pop()},
            ),
          ],
        ),
      ),
    );
  }
}
