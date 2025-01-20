import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/message_model.dart';


class DatabaseWhatsAppMessageHelper {
  static final DatabaseWhatsAppMessageHelper instance = DatabaseWhatsAppMessageHelper._init();
  static Database? _database;

  DatabaseWhatsAppMessageHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('messages.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('DROP TABLE IF EXISTS messages');
    await db.execute('''
      CREATE TABLE messages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        messageId TEXT NOT NULL
      )
    ''');
  }

  // Insert a notification
  Future<int> insertMessageId(MessageModel notification) async {
    final db = await instance.database;
    return await db.insert('messages', notification.toMap());
  }

  // Retrieve all notifications
  Future<List<String>> fetchAllMessageIdsRead() async {
    final db = await instance.database;
    final result = await db.query('messages');
    return result.map((map) => MessageModel.fromMap(map).messageId).toList();
  }

  Future<void> deleteAll() async {
    final db = await instance.database;
    await db.delete('messages'); // Deletes all rows from the notifications table
  }

  // Delete a notification
  Future<int> deleteNotification(int id) async {
    final db = await instance.database;
    return await db.delete(
      'messages',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
