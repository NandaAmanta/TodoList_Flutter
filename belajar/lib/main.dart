// @dart=2.9
import 'dart:ffi';

import 'package:belajar/model/Todolist_model.dart';
import 'package:belajar/repository/Todolist_repository.dart';
import 'package:belajar/repository/todolist_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'repository/database.dart';
import 'service/Todolist_Service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FirebaseApp app = await Firebase.initializeApp();
  runApp(MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.lightGreen,
          accentColor: Colors.orange,
          textTheme: TextTheme(title: TextStyle(color: Colors.white))),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: MyApp(app: app)));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key, this.app}) : super(key: key);

  final FirebaseApp app;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> todos = [];

  final _inputValuesTodos = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _inputValuesTodos.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("To Do List", style: Theme.of(context).textTheme.title),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return AlertDialog(
                      title: Text(
                        "Masukan To do Kamu !",
                        style: TextStyle(color: Colors.black),
                      ),
                      content: TextField(controller: _inputValuesTodos),
                      actions: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                //todos.add(_inputValuesTodos.text);
                              });
                              Navigator.pop(dialogContext);
                            },
                            child: Text(
                              "Tambah",
                              style: TextStyle(color: Colors.lightBlue),
                            ))
                      ],
                    );
                  });
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            )),
        body: FutureBuilder<List<TodoList>>(
          future: TodolistServie().getTodosList(),
          builder:
              (BuildContext context, AsyncSnapshot<List<TodoList>> snapshot) {
            Widget dataTask;
            print("snapshott:" + snapshot.data.toString());
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                      background: Container(
                        color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          
                          final todos_left = snapshot.data.length;
                          Scaffold.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("$todos_left tasks left")));
                        });
                      },
                      key: UniqueKey(),
                      child: Card(
                        child: ListTile(
                          title: Text(snapshot.data[index].task),
                        ),
                      ));
                },
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(
                child: Icon(
                  Icons.error_outline,
                  size: 50,
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
