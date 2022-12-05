class TodoModel {
  TodoModel({this.todo});

  String? todo;

  //return a Map; Key value pair of to
  Map<String, dynamic> toMap() {
    return {"todo": todo};
  }
}
