import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/data/task_contract.dart';

class TaskDBHelper {
  static TaskDBHelper _taskDBHelper;
  static Database _database;

  TaskDBHelper.createInstance();

  factory TaskDBHelper() {
    if (_taskDBHelper == null) {
      _taskDBHelper = TaskDBHelper.createInstance();
    }
    return _taskDBHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    String path = join(await getDatabasesPath(), TaskContract.dbName);
    return openDatabase(path, version: TaskContract.dbVersion,
        onCreate: (db, version) {
      String createStatement = "CREATE TABLE " +
          TaskContract.tableName +
          "(" +
          TaskContract.colID +
          " INTEGER  PRIMARY KEY AUTOINCREMENT," +
          TaskContract.colTitle +
          " TEXT NOT NULL," +
          TaskContract.colDesc +
          " TEXT," +
          TaskContract.colIsComplete +
          " INT DEFAULT 0," +
          TaskContract.colDate +
          " DATE DEFAULT CURRENT_TIMESTAMP " +
          ")";
      return db.execute(createStatement);
    });
  }
}
