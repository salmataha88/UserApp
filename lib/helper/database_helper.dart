import 'dart:typed_data';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY,
        name TEXT,
        email TEXT,
        studentId TEXT,
        password TEXT,
        profilePhoto BLOB,
        level TEXT,
        gender TEXT
      )
    ''');
    print("==========Create db=========");
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await instance.database;
    print("=======ADD USER======");
    return await db.insert('users', user);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    Database db = await instance.database;
    return await db.query('users');
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    print(users.first);
    return users.isNotEmpty ? users.first : null;
  }

  Future<int> updateUser(String email, Map<String, dynamic> updatedUserData) async {
    try {
      Database db = await instance.database;
      int rowsAffected = await db.update(
        'users',
        updatedUserData,
        where: 'email = ?',
        whereArgs: [email],
      );
      return rowsAffected;
    } catch (e) {
      if (e is DatabaseException && e.isOpenFailedError()) {
        print('Database is closed. Reopening and retrying...');
        await DatabaseHelper.instance._initDatabase();
        return await updateUser(email, updatedUserData);
      } else {
        print('Error updating user data: $e');
        return 0;
      }
    }
  }
    Future<void> updateUserPhoto(String email, Uint8List photoData) async {
    try {
      Database db = await instance.database;
      int rowsAffected = await db.update(
        'users',
        {'profilePhoto': photoData},
        where: 'email = ?',
        whereArgs: [email],
      );
      print('Updated $rowsAffected rows');
    } catch (e) {
      print('Error updating user photo: $e');
    }
  }


}