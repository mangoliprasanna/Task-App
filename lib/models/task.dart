import 'package:tasks/data/task_contract.dart';

class Task{
	int _taskID;
	String _taskTitle;
	String _taskDesc;
	String _taskDate;

	Task(this._taskTitle, [this._taskDesc, this._taskDate]);

	String get taskTitle => this._taskTitle;

	String get taskDesc => this._taskDesc;

	String get taskDate => this._taskDate;

	int get taskID => this._taskID;

	Map<String, dynamic> toMap() {
		var taskMap = new Map<String, dynamic>();
		taskMap[TaskContract.colDate] = this._taskDate;
		taskMap[TaskContract.colTitle] = this._taskTitle;
		taskMap[TaskContract.colDesc] = this._taskDesc;
		taskMap[TaskContract.colID	] = this._taskID;
		return taskMap;
	}

	Task.fromMap(Map<String, dynamic> taskMap){
		this._taskDate = taskMap[TaskContract.colDate];
		this._taskTitle = taskMap[TaskContract.colTitle];
		this._taskDesc = taskMap[TaskContract.colDesc];
		this._taskID = taskMap[TaskContract.colID];
	}

}