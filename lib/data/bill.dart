import 'package:flutter_app/data/db.dart';
import 'package:sqflite/sqflite.dart';

final dayOfWeek = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];

class Bill {
  const Bill();

  static Map<String, List<BillItem>> billsGroupByDays(
    List<BillItem> billItems,
  ) {
    final Map<String, List<BillItem>> maps = {};
    billItems.forEach((element) {
      final day = element.dayFmt();
      if (!maps.containsKey(day)) {
        maps[day] = [];
      }
      maps[day].add(element);
    });
    return maps;
  }

  /// 获取指定月份所有账单
  static Future<List<BillItem>> loadMonthBills(String month) async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query(
      'bills',
      where: "strftime('%Y.%m') = ?",
      whereArgs: [month],
      orderBy: "date DESC",
    );
    return List.generate(maps.length, (i) {
      return BillItem(
        id: maps[i]['id'],
        date: DateTime.fromMicrosecondsSinceEpoch(maps[i]['date']),
        name: maps[i]['name'],
        remark: maps[i]['remark'],
        amount: maps[i]['amount'],
      );
    });
  }

  static Future<void> insertBill(BillItem billItem) async {
    final db = await database();
    await db.insert(
      'bills',
      billItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  loadFromSQLite() async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query('bills');
    maps.forEach((element) {
      print('$element');
    });
  }
}

class BillItem {
  final int id;
  final DateTime date;
  final String name;
  final String remark;
  final double amount;

  const BillItem({this.id, this.date, this.name, this.amount, this.remark});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.microsecondsSinceEpoch,
      'name': name,
      'remark': remark,
      'amount': amount,
    };
  }

  String dayFmt() {
    return "${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}";
  }

  String dateFmt() {
    var day = date.day;
    var chinese = dayOfWeek[date.weekday - 1];
    var now = DateTime.now();
    if (day == now.day) {
      chinese = '今天';
    } else if (day == now.day - 1) {
      chinese = '昨天';
    } else if (day == now.day - 2) {
      chinese = '前天';
    }
    return "${dayFmt()} $chinese";
  }
}
