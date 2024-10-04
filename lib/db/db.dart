import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_app/model/usermodel/user.dart';

class DatabaseHelper {
  static final DatabaseHelper object = DatabaseHelper._init();
  static Database? database;
  DatabaseHelper._init();
  Future<Database> get db async {
    if (database != null) return database!;
    database = await initdb('user.db');
    return database!;
  }

  Future<Database> initdb(String filePath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filePath);
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE user
    (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL,
    pass TEXT NOT NULL   

    )
    ''');
  }

  Future<int> insertUser(UserModel user) async {
    Database database = await object.db;
    return await database.insert('user', user.tomap());
  }

////////////////////////////
  Future<int> updateUser(UserModel user) async {
    Database database = await object.db;
    return await database.update(
      'user',
      user.tomap(),
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  ////////////////////////////////
  Future<UserModel?> queryUser() async {
    Database database = await object.db;
    List<Map<String, dynamic>> query = await database.query('user');
    if (query.isNotEmpty) {
      return UserModel.fromMap(query.first);
    }
    return null;
  }
}
