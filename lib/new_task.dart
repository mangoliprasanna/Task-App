import 'package:flutter/material.dart';
import 'package:tasks/data/task_provider.dart';
import 'package:tasks/models/task.dart';

class NewTask extends StatefulWidget {
  final TaskProvider _taskProvider;
  NewTask(this._taskProvider, {Key key}) : super(key: key);
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  var descVisibility = false;
  TextEditingController _taskTitleController = TextEditingController();
  TextEditingController _taskDescController = TextEditingController();
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
                height: 50.0,
              ),
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
                      onTap: () async {
                        var selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            initialDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 30)));
                        print((selectedDate.toString() ?? "hello"));
                      },
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (descVisibility &&
                          _taskDescController.text.length > 0) {
                        widget._taskProvider.insertTask(Task(
                            _taskTitleController.text,
                            _taskDescController.text));
                      } else if (_taskTitleController.text.length > 0) {
                        widget._taskProvider
                            .insertTask(Task(_taskTitleController.text));
                      }
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
