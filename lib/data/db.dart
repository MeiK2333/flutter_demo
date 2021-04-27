import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> database() async {
  WidgetsFlutterBinding.ensureInitialized();
  return openDatabase(
    join(await getDatabasesPath(), 'database.db'),
    onCreate: (db, version) {
      return db.execute(
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
    },
    version: 1,
  );
}
