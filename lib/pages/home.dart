import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/data/bill.dart';
import 'package:flutter_app/pages/booking.dart';
import 'package:flutter_app/pages/home_card.dart';
import 'package:flutter_app/pages/nav_drawer.dart';
import 'package:flutter_app/utils.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  DateTime date = DateTime.now();
  Map<String, List<BillItem>> billItems = Map();
  ScrollController _scrollController;
  AnimationController _hideFabAnimController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _hideFabAnimController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 1, // initially visible
    );
    _scrollController.addListener(() {
      switch (_scrollController.position.userScrollDirection) {
        case ScrollDirection.forward:
          _hideFabAnimController.forward();
          break;
        case ScrollDirection.reverse:
          _hideFabAnimController.reverse();
          break;
        case ScrollDirection.idle:
          break;
      }
    });

    super.initState();

    Bill.loadMonthBills(Utils.yearMonthFmt(date)).then((value) {
      setState(() {
        billItems = Bill.billsGroupByDays(value);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _hideFabAnimController.dispose();
    super.dispose();
  }

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
            Utils.yearMonthFmt(date),
            style: TextStyle(color: Color(0xffbdbdbd)),
          ),
          onTap: () async {
            // TODO: 选择月份
            final items = await Bill.loadMonthBills(Utils.yearMonthFmt(date));
            setState(() {
              billItems = Bill.billsGroupByDays(items);
              // date = date.subtract(Duration(days: 30));
            });
          },
        ),
      ),
      floatingActionButton: FadeTransition(
        opacity: _hideFabAnimController,
        child: ScaleTransition(
          scale: _hideFabAnimController,
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              // 跳转到记账页面
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Booking(date: DateTime.now())),
              );
            },
            tooltip: 'Increment',
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: NavDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      body: ListView(
        controller: _scrollController,
        padding: EdgeInsets.all(0),
        children: <Widget>[
              // TODO: 指定分辨率
              Container(
                height: 320,
                padding: EdgeInsets.only(bottom: 8),
                child: Image(image: AssetImage('assets/home.jpg')),
              ),
            ] +
            billItems.entries.map<Widget>((e) => MyHomeCard(e)).toList(),
      ),
    );
  }
}
