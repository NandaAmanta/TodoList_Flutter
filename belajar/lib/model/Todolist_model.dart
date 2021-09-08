class TodoList {
  DateTime? deadline;
  final String task;
  final String by;

  TodoList(this.deadline,this.task,this.by);

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