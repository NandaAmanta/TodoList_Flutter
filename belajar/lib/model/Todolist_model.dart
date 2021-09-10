import 'package:belajar/repository/database.dart';
import 'package:firebase_database/firebase_database.dart';

class TodoList {
  final String task;
  final String by;
  DateTime? deadline;
  

  TodoList(this.task,this.by,this.deadline);

  Map<String,dynamic> ToJson(){
    return {
      "task" : this.task,
      "deadline" : this.deadline,
      "by"  : this.by
    };
  }

  factory TodoList.fromJson(Map<dynamic,dynamic> json ){
    return TodoList(json["deadline"] == null ? DateTime.now() : json["deadline"] ,json["task"] , json["by"]);
  }

}