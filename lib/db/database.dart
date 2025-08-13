import 'package:orm_floor/db/app_database.dart';

class Database {
  static AppDatabase? _database;

  static Future<AppDatabase?> getDataBase() async {
    if (_database != null) return _database;

    _database = await $FloorAppDatabase
        .databaseBuilder("app_database.db")
        .build();

    return _database;
  }
}
