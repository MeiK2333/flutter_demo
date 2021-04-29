import 'package:flutter_app/data/db.dart';

List<Category> expenditureCategory = [];
List<Category> incomeCategory = [];

class Category {
  final int id;
  final String name;
  final bool income;
  final int rank;
  final String icon;

  const Category({this.id, this.name, this.income, this.icon, this.rank});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'income': income ? 1 : 0,
      'rank': rank,
      'icon': icon,
    };
  }

  static void initCategory() {
    Category.loadCategory(income: false).then((value) {
        expenditureCategory = value;
    });
    Category.loadCategory(income: true).then((value) {
        incomeCategory = value;
    });
  }

  static Future<List<Category>> loadCategory({bool income = false}) async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query(
      'category',
      where: "income = ?",
      whereArgs: [income ? 1 : 0],
      orderBy: "rank",
    );
    return List.generate(maps.length, (i) {
      return Category(
        id: maps[i]['id'],
        name: maps[i]['name'],
        income: maps[i]['income'] == 1 ? true : false,
        rank: maps[i]['rank'],
        icon: maps[i]['icon'],
      );
    });
  }
}

final List<Category> defaultCategory = [
  Category( name: '三餐', income: false, icon: '三餐', rank: 0),
  Category( name: '零食', income: false, icon: '零食', rank: 1),
  Category( name: '衣服', income: false, icon: '衣服', rank: 2),
  Category( name: '交通', income: false, icon: '交通', rank: 3),
  Category( name: '旅行', income: false, icon: '旅行', rank: 4),
  Category( name: '孩子', income: false, icon: '孩子', rank: 5),
  Category( name: '宠物', income: false, icon: '宠物', rank: 6),
  Category( name: '通讯费用', income: false, icon: '通讯费用', rank: 7),
  Category( name: '烟酒', income: false, icon: '烟酒', rank: 8),
  Category( name: '学习', income: false, icon: '学习', rank: 9),
  Category( name: '日用品', income: false, icon: '日用品', rank: 10),
  Category( name: '住房', income: false, icon: '住房', rank: 11),
  Category( name: '美妆', income: false, icon: '美妆', rank: 12),
  Category( name: '医疗', income: false, icon: '医疗', rank: 13),
  Category( name: '红包', income: false, icon: '红包', rank: 14),
  Category( name: '汽车', income: false, icon: '汽车', rank: 15),
  Category( name: '娱乐', income: false, icon: '娱乐', rank: 16),
  Category( name: '请客送礼', income: false, icon: '请客送礼', rank: 17),
  Category( name: '电器数码', income: false, icon: '电器数码', rank: 18),
  Category( name: '运动', income: false, icon: '运动', rank: 19),
  Category( name: '水电', income: false, icon: '水电', rank: 20),
  Category( name: '其他', income: false, icon: '其他', rank: 21),
];
