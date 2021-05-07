import 'package:flutter/material.dart';
import 'package:flutter_app/data/bill.dart';
import 'package:flutter_app/data/category.dart';
import 'package:flutter_app/data/icons.dart';
import 'package:flutter_app/pages/number_text.dart';
import 'package:flutter_app/utils.dart';

class Booking extends StatefulWidget {
  final DateTime date;

  const Booking({this.date});

  @override
  _Booking createState() => _Booking();
}

class _Booking extends State<Booking> {
  int selected = -1;
  double value = 0;
  final NumberTextController controller = NumberTextController();
  final TextEditingController textEditingController = TextEditingController();
  NumberText numberText = NumberText();

  @override
  void initState() {
    super.initState();
    if (expenditureCategory.length > 0) {
      selected = expenditureCategory[0].id;
    }
  }

  Widget _buildTabBarView(List<Category> category) {
    return SingleChildScrollView(
      child: Center(
        child: Wrap(
          runSpacing: 12,
          spacing: -14,
          children: category.map<Widget>((e) {
            return Column(
              children: [
                RawMaterialButton(
                  onPressed: () {
                    setState(() {
                      selected = e.id;
                    });
                  },
                  elevation: 2.0,
                  fillColor:
                      selected == e.id ? Color(0xff3275c8) : Color(0xff333333),
                  hoverColor: Color(0xff3275c8),
                  highlightColor: Color(0xff3275c8),
                  focusColor: Color(0xff3275c8),
                  splashColor: Color(0xff3275c8),
                  child: Icon(
                    HelperIcons.getIconData(e.icon),
                    size: 22,
                    color: selected == e.id ? Colors.white : Color(0xffaaaaaa),
                  ),
                  padding: EdgeInsets.all(5),
                  shape: CircleBorder(),
                ),
                Text(
                  e.name,
                  style: TextStyle(
                    color: selected == e.id
                        ? Color(0xff3275c8)
                        : Color(0xffaaaaaa),
                    fontSize: 12,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildInputRow() {
    return Padding(
      padding: EdgeInsets.only(left: 14, right: 14),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: textEditingController,
              style: TextStyle(
                color: Color(0xff3275c8),
              ),
              decoration: const InputDecoration(
                hintText: '点此输入备注…',
                hintStyle: TextStyle(color: Color(0xffaaaaaa), fontSize: 14),
              ),
            ),
          ),
          NumberText(
            controller: controller,
          ),
        ],
      ),
    );
  }

  Widget _buildTagRow() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Wrap(
          children: [
            TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(50, 25),
                  primary: Color(0xffaaaaaa),
                  backgroundColor: Color(0xff222222),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                onPressed: () {
                  // TODO: 选择日期
                },
                child: Text(Utils.monthDayFmt(widget.date))),
          ],
        ),
      ),
    );
  }

  Widget _numberInput(Widget widget, String operator) {
    return InkWell(
      onTap: () {
        controller.setValue(operator);
      },
      child: Container(
        alignment: Alignment.center,
        child: widget,
        height: 50,
        width: MediaQuery.of(context).size.width / 4,
      ),
    );
  }

  Widget _numberInputNum(String num) {
    return _numberInput(
        Text(
          "$num",
          style: TextStyle(
            fontSize: 18,
            color: Color(0xffbebebe),
          ),
        ),
        num);
  }

  Widget _numberInputItemText(String item) {
    return InkWell(
      onTap: () async {
        var val = controller.getValue();
        if (val <= 0) {
          // TODO: 提示
          return;
        }
        Category category;
        expenditureCategory.forEach((element) {
          if (element.id == selected) {
            category = element;
          }
        });
        if (category == null) {
          return;
        }
        BillItem billItem = BillItem(
          date: widget.date,
          name: category.name,
          amount: val,
          remark: textEditingController.text,
        );
        await Bill.insertBill(billItem);
        billListen.value++;
        print('${billListen.value}');
        Navigator.pop(context);
        if (item == '再记') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Booking(date: DateTime.now())),
          );
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 4,
        height: 50,
        color: item == '保存' ? Color(0xffb85855) : null,
        child: Text(
          "$item",
          style: TextStyle(
            fontSize: 12,
            color: item == '保存' ? Colors.white : Color(0xffbebebe),
          ),
        ),
      ),
    );
  }

  Widget _numberInputItemIcon(IconData iconData, String operator) {
    return _numberInput(
        Icon(
          iconData,
          size: 18,
          color: Color(0xffaaaaaa),
        ),
        operator);
  }

  /// 最底下那个数字输入控件
  Widget _buildNumberInput() {
    return Column(
      children: [
        Row(
          children: [
            // TODO: 优化重复部分，添加点击事件
            _numberInputNum('1'),
            _numberInputNum('2'),
            _numberInputNum('3'),
            _numberInputItemIcon(Icons.backspace, '<'),
          ],
        ),
        Row(
          children: [
            _numberInputNum('4'),
            _numberInputNum('5'),
            _numberInputNum('6'),
            _numberInputItemIcon(Icons.remove, '-'),
          ],
        ),
        Row(
          children: [
            _numberInputNum('7'),
            _numberInputNum('8'),
            _numberInputNum('9'),
            _numberInputItemIcon(Icons.add, '+'),
          ],
        ),
        Row(
          children: [
            _numberInputItemText('再记'),
            _numberInputNum('0'),
            _numberInputNum('.'),
            _numberInputItemText('保存'),
          ],
        ),
      ],
    );
  }

  AppBar appBar = AppBar(
    backgroundColor: Colors.black,
    centerTitle: true,
    title: TabBar(
      labelStyle: TextStyle(fontSize: 18, color: Color(0xfbcbcbc)),
      unselectedLabelStyle: TextStyle(fontSize: 18, color: Color(0xff7f7f7f)),
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
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xff111111),
        appBar: appBar,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: TabBarView(
                  children: [
                    _buildTabBarView(expenditureCategory),
                    _buildTabBarView(incomeCategory),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildInputRow(),
                  _buildTagRow(),
                  _buildNumberInput(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
