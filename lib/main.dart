import 'package:flutter/material.dart';
import 'package:tasks/data/task_provider.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/new_task.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'My Tasks',
      ),
    );
  }
}

class ModalSample extends StatelessWidget {
  const ModalSample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  labelText: 'Input Text', border: InputBorder.none),
            )
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TaskProvider _dbProvider;

  @override
  void initState() {
    _dbProvider = new TaskProvider();
    super.initState();
  }

  _modalBottomSheetMenu() {
    var result = showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (builder) {
        return NewTask(_dbProvider);
      },
    );
    result.then((v) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.blue,
        child: Container(
          padding: EdgeInsets.only(top: 40.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0)),
          ),
          child: FutureBuilder(
            future: _dbProvider.getTasks(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                List<Task> allTask = snapshot.data;
                if (allTask.length > 0) {
                  return ListView.builder(
                      itemCount: allTask.length,
                      itemBuilder: (context, position) {
                        return Dismissible(
                          key: ValueKey(allTask[position].taskID),
                          child: ListTile(
                            onTap: () {
                              print("");
                            },
                            title: Text(
                              allTask[position].taskTitle,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            subtitle: Text(allTask[position].taskDesc ?? ""),
                          ),
                          background: Container(
                            color: Colors.blue,
                            padding: EdgeInsets.all(10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                          ),
                          secondaryBackground: Container(
                            color: Colors.red,
                            padding: EdgeInsets.all(10.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.delete_sweep,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                          ),
                          onDismissed: (direction) {
                            if (direction.index == 2) {
                              Task currentTask = allTask[position];
                              _dbProvider.deleteTask(allTask[position]);
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Task Deleted."),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    _dbProvider.insertTask(currentTask);
                                    setState(() {});
                                  },
                                ),
                              ));
                            } else {
                              print("Complete");
                            }
                            allTask.removeAt(position);
                          },
                        );
                      });
                } else {
                  return Text("No task found :(");
                }
              } else {
                return Text("Error");
              }
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _modalBottomSheetMenu();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
