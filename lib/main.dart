import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

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
        title: InkWell(
          child: Text(
            '2021.04',
            style: TextStyle(color: Color(0xffbdbdbd)),
          ),
          onTap: () {},
        ),
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
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
              color: Color(0xff191919),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 8, bottom: 8, left: 14, right: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "04.26 今天",
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
                  Padding(
                    padding:
                        EdgeInsets.only(top: 8, bottom: 8, left: 14, right: 14),
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
                                text: "三餐",
                                style: TextStyle(
                                  color: Color(0xffbdbdbd),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "-50.00",
                          style: TextStyle(
                            color: Color(0xffb85855),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 8, bottom: 8, left: 14, right: 14),
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
                                text: "三餐",
                                style: TextStyle(
                                  color: Color(0xffbdbdbd),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "-50.00",
                          style: TextStyle(
                            color: Color(0xffb85855),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
