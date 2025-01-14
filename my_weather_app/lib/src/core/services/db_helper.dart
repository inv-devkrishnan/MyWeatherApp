import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // class that helps to establish db connection and create db tables
  static const _databaseName = "myDatabase.db";
  static const _databaseVersion = 1;

  static const locationName = 'location_name';
  static const favoritesTable = 'favorites';
  static const userId = 'uid';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE $favoritesTable (
            $userId TEXT  ,
            $locationName TEXT NOT NULL,
            CONSTRAINT PK_favorite PRIMARY KEY ($userId,$locationName)
          )
          ''');
    });
  }
}
