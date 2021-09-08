
import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';


class DataBase {
  final db = FirebaseDatabase.instance.reference().child("/todolist/");
 
  DatabaseReference getDatabaseTodoList(){
    return this.db;
  }
}
 