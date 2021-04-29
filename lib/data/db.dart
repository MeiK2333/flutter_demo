import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter_app/data/category.dart';

Future<Database> database() async {
  WidgetsFlutterBinding.ensureInitialized();
  return openDatabase(
    join(await getDatabasesPath(), 'database.db'),
    onCreate: (db, version) {
      db.execute(
        """
create table bills
(
    id integer PRIMARY KEY autoincrement,
    date datetime not null default (datetime('now', 'localtime')),
    name text not null,
    remark text not null default '',
    amount double not null
)
        """,
      );
      db.execute(
        """
create table category
(
    id     integer PRIMARY KEY autoincrement,
    name   text    not null,
    income bool    not null default true,
    rank   integer not null,
    icon   text    not null default ''
)
        """,
      );
      defaultCategory.forEach((element) {
        db.insert(
          'category',
          element.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });
    },
    version: 1,
  );
}
