import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:tasks/data/task_contract.dart';
import 'package:tasks/data/task_dbhelper.dart';
import 'package:tasks/models/task.dart';

class TaskProvider {
  TaskDBHelper _taskDBHelper;
  TaskProvider() {
    this._taskDBHelper = new TaskDBHelper();
  }

  Future<int> insertTask(Task task) async {
    Database db = await this._taskDBHelper.database;
    return db.insert(TaskContract.tableName, task.toMap());
  }

  Future<List<Task>> getTasks() async {
    List<Task> allTask = new List<Task>();
    Database db = await this._taskDBHelper.database;
    var rawData = await db.query(TaskContract.tableName);
    rawData.forEach((task) => allTask.add(Task.fromMap(task)));
    return allTask;
  }

  Future<int> deleteTask(Task task) async {
    Database db = await this._taskDBHelper.database;
    return db.delete(TaskContract.tableName, where: TaskContract.colID + "=?", whereArgs: [task.taskID]);
  }

}
