import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ImageInSqliteDBdb {
  Future<Database> GetDB() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'imagedb.db');
    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE IMAGE (ID INTEGER PRIMARY KEY AUTOINCREMENT, PATH TEXT)');
    });
    return database;
  }

  Future<int> AddImage(String? path, Database db) {
    String insert = "insert into IMAGE (PATH)  values('$path')";
    Future<int> a = db.rawInsert(insert);
    return a;
  }

  Future<List<Map>> GetImage(Database db) async {
    String notes = "select * from IMAGE";
    List<Map> data = await db.rawQuery(notes);
    return data;
  }
}
