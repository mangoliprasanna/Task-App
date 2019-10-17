import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/data/task_provider.dart';
import 'package:tasks/models/task.dart';

class NewTask extends StatefulWidget {
  final TaskProvider _taskProvider;
  NewTask(this._taskProvider, {Key key}) : super(key: key);
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  var descVisibility = false;
  DateTime _taskDate;
  TextEditingController _taskTitleController = TextEditingController();
  TextEditingController _taskDescController = TextEditingController();

  void changeDateTime() async {
    var selectedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now().subtract(Duration(hours: 10)),
        initialDate: (_taskDate != null)
            ? DateTime(_taskDate.year, _taskDate.month, _taskDate.day)
            : DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 30)));
    if (selectedDate != null) {
      var selectedTime = await showTimePicker(
          context: context,
          initialTime: (_taskDate != null)
              ? TimeOfDay(hour: _taskDate.hour, minute: _taskDate.minute)
              : TimeOfDay.now());
      if (selectedTime != null) {
        setState(() {
          _taskDate = new DateTime(selectedDate.year, selectedDate.month,
              selectedDate.day, selectedTime.hour, selectedTime.minute);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.multiline,
                controller: _taskTitleController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    border: InputBorder.none,
                    hintText: 'New Task',
                    hintStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              (descVisibility)
                  ? TextField(
                      controller: _taskDescController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 8.0),
                          border: InputBorder.none,
                          hintText: 'Add details'),
                    )
                  : Container(),
              Container(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: (_taskDate != null)
                      ? Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(Icons.calendar_today),
                            ),
                            InkWell(
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(new DateFormat("d MMMM, h:mm a")
                                    .format(_taskDate)),
                              ),
                              onTap: changeDateTime,
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: InkWell(
                                child: Icon(Icons.close),
                                onTap: () {
                                  setState(() {
                                    _taskDate = null;
                                  });
                                },
                              ),
                            )
                          ],
                        )
                      : Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: InkWell(
                      child: Icon(Icons.playlist_add,
                          size: 35.0, color: Colors.blue),
                      onTap: () {
                        setState(() {
                          descVisibility = (descVisibility) ? false : true;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: InkWell(
                      child: Icon(Icons.calendar_today,
                          size: 30.0, color: Colors.blue),
                      onTap: changeDateTime,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Task newTask;
                      if (descVisibility &&
                          _taskDescController.text.length > 0) {
                          newTask = Task(_taskTitleController.text, _taskDescController.text, _taskDate.toString());
                      } else if (_taskTitleController.text.length > 0) {
                        newTask = Task(_taskTitleController.text);
                      }

                      if(_taskDate != null){
                        newTask.setDate(_taskDate.toString());
                      }
                      widget._taskProvider.insertTask(newTask);
                      Navigator.pop(context);
                    },
                    color: Colors.transparent,
                    textColor: Colors.blue,
                    elevation: 0.0,
                    highlightElevation: 0.0,
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
