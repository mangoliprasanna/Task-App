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

  Future<List<Task>> getPendingTasks() async {
    List<Task> allTask = new List<Task>();
    Database db = await this._taskDBHelper.database;
    var rawData = await db.query(TaskContract.tableName, where: TaskContract.colIsComplete + "=?", whereArgs: [Task.taskInComplete]);
    rawData.forEach((task) => allTask.add(Task.fromMap(task)));
    return allTask;
  }

  void updateTask(Task task) async {
    Database db = await this._taskDBHelper.database;
    Map<String, dynamic> updateRow = {
      TaskContract.colIsComplete : task.isComplete
    };
    db.update(TaskContract.tableName, updateRow, where: TaskContract.colID + "=?", whereArgs: [task.taskID]);
  }

  Future<List<Task>> getCompletedTasks() async {
    List<Task> allTask = new List<Task>();
    Database db = await this._taskDBHelper.database;
    var rawData = await db.query(TaskContract.tableName, where: TaskContract.colIsComplete + "=?", whereArgs: [Task.taskComplete]);
    rawData.forEach((task) => allTask.add(Task.fromMap(task)));
    return allTask;
  }

  Future<int> deleteTask(Task task) async {
    Database db = await this._taskDBHelper.database;
    return db.delete(TaskContract.tableName, where: TaskContract.colID + "=?", whereArgs: [task.taskID]);
  }

}
