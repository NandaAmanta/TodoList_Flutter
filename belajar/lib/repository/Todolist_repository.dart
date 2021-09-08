import 'package:belajar/model/Todolist_model.dart';
import 'package:belajar/repository/database.dart';
import 'package:firebase_database/firebase_database.dart';



class TodoListRepo{

  final db = DataBase().getDatabaseTodoList();

  Future<List<Map<dynamic,dynamic>>> getDataTask() async{


    return await db.once().then((value) {
      print(value.value);

      return value.value;
    });



  }

}