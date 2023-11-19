class TodoModel {
  String? todo;

  TodoModel({this.todo});

  //return a Map; Key-Value pair of Todo Model ;
  //Needed cos most database function required it to be a MAP

  Map<String, dynamic> toMap() {
    return {"todo": todo};
  }
}
