import 'dart:ui';

import 'package:task_app/Models/signupmodel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String databaseName = 'databaseuser.db';
  static const int databaseVersion = 1;
  static const String columeId = 'id';
  static const String columeIdType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String username = 'username';
  static const String password = 'password';
  static const String table = 'usertable';

  DatabaseHelper._instance();
  static final DatabaseHelper dbInstance = DatabaseHelper._instance();
  static Database? database;
  Future<Database> get getDatabase async {
    if (database != null) return database!;
    database = await initialDatabase();
    return database!;
  }

  Future<Database> initialDatabase() async {
    String dbPath = join(await getDatabasesPath(), databaseName);
    return await openDatabase(dbPath,
        version: databaseVersion, onCreate: createDatabaseTables);
  }

  Future<void> createDatabaseTables(Database db, int version) async {
    await db.execute('''
      Create Table $table
      (
      $columeId $columeIdType,
      $username TEXT NOT NULL,
      $password TEXT NOT NULL
      )
      ''');
  }

  Future<int> insert(SignupModel user) async {
    Database db = await dbInstance.getDatabase;
    return await db.insert(table, user.toMap());
  }

  Future<int> update(SignupModel user) async {
    Database db = await dbInstance.getDatabase;
    return await db.update(
      table,
      user.toMap(),
      where: '$columeId = ?',
      whereArgs: [user.id],
    );
  }

  Future<SignupModel?> queryUser() async {
    Database db = await dbInstance.getDatabase;
    List<Map<String, dynamic>> userdata = await db.query(table);
    if (userdata.isNotEmpty) {
      SignupModel.fromMap(userdata.first);
      return null;
    }
  }

  Future<List<SignupModel>> readAllUser() async {
    final db = await dbInstance.getDatabase;
    const orderBy = 'date ASC';
    final result = await db.query('user', orderBy: orderBy);
    return result.map((datafromdb) => SignupModel.fromMap(datafromdb)).toList();
  }

  Future<int> create(SignupModel user) async {
    final db = await dbInstance.getDatabase;
    return await db.insert('user', user.toMap());
  }
}
