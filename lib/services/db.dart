import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static final DB instance = DB._();

  DB._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await init();
    return _database!;
  }

  Future<Database> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join(await getDatabasesPath(), 'test.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, username TEXT,email TEXT)',
        );
      },
      version: 1,
    );
  }

}
