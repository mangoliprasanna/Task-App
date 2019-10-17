import 'package:tasks/data/task_contract.dart';

class Task {
  static int taskInComplete = 0;
  static int taskComplete = 1;

  int _taskID;
  String _taskTitle;
  String _taskDesc;
  String _taskDate;
  int _isComplete = taskInComplete;

  Task(this._taskTitle, [this._taskDesc, this._taskDate]);

  String get taskTitle => this._taskTitle;

  String get taskDesc => this._taskDesc;

  String get taskDate => this._taskDate;

  int get taskID => this._taskID;

  int get isComplete => this._isComplete;

  void complete() {
    this._isComplete = Task.taskComplete;
  }

  void setDate(String date) {
    this._taskDate = date;
  }

  Map<String, dynamic> toMap() {
    var taskMap = new Map<String, dynamic>();
    if (this._taskDate != null) {
      this._taskDate = taskMap[TaskContract.colDate];
    }
    taskMap[TaskContract.colTitle] = this._taskTitle;
    taskMap[TaskContract.colDesc] = this._taskDesc;
    taskMap[TaskContract.colID] = this._taskID;
    taskMap[TaskContract.colIsComplete] = this._isComplete;
    return taskMap;
  }

  Task.fromMap(Map<String, dynamic> taskMap) {
    this._taskDate = taskMap[TaskContract.colDate];
    this._taskTitle = taskMap[TaskContract.colTitle];
    this._taskDesc = taskMap[TaskContract.colDesc];
    this._taskID = taskMap[TaskContract.colID];
    this._isComplete = taskMap[TaskContract.colIsComplete];
  }
}
