

import 'package:belajar/model/Todolist_model.dart';
import 'package:belajar/repository/database.dart';
import 'package:firebase_database/firebase_database.dart';

class TodoListRepo{

  final db = DataBase().getDatabaseTodoList();
  List<TodoList> data = [];
  

  Future <List<TodoList>> getDataTask() async{
      
    return await db.once().then((value){
      for(var val in value.value){
        data.add(new TodoList(val["task"],val["by"],val["deadline"]) );
      }
      return data;

    });

  }

  

} 