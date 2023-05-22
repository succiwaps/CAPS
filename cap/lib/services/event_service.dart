import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cap/models/event.dart';

class EventDatabase {
  static final EventDatabase instance = EventDatabase._init();

  static Database? _database;

  EventDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('events.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS events(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        startDate TEXT,
        endDate TEXT,
        location TEXT,
        description TEXT,
        attendees TEXT,
        type TEXT
      )
    ''');
  }

  Future<int> insertEvent(Event event) async {
    final db = await instance.database;
    return await db.insert('events', event.toMap());
  }

  // Add other methods for retrieving and manipulating events
}
