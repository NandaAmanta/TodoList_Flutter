
import 'package:belajar/model/Todolist_model.dart';
import 'package:belajar/repository/Todolist_repository.dart';

class TodolistServie{

    Future <List<TodoList>> getTodosList() async{
      return TodoListRepo().getDataTask();
    }

}