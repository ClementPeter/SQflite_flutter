import 'package:db__sqflite/models/todo_models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Create the sqflite database
Future<Database> todoDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(),
        "flutter_todo.db"), //Auto get the path the database storage and add our file
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE todo (id INTEGER PRIMARY KEY, todo TEXT)'); //specify the name of the database table and parameters it contains; parameters depend on model class
    },
    version: 1, //Add version
  );
}

//Add Todo to Databse
Future<TodoModel> addTodo({TodoModel? todo}) async {
  final db = await todoDatabase();

  //Insert data into the "todo" table; insert takes a map whhich in this case our Todo model returns
  db.insert("todo", todo!.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace); 
  print(todo);
  return todo;
}

//Update Todo --not in use
Future<TodoModel> updateToDo({List? id, TodoModel? todo}) async {
  final db = await todoDatabase();
  db.update("todo", todo!.toMap(), where: "id =?", whereArgs: id);
  return todo;
}

//Delete Todo - delete todo requires just a List [id]
Future deleteToDo({List? id}) async {
  final db = await todoDatabase();
  db.delete("todo");
}

//Read Todo - Fetches content out of the Database Table
Future readToDo() async {
  final db = await todoDatabase();
  return db.query("todo");
}












    // body: Container(
    //     padding: const EdgeInsets.symmetric(horizontal: 20),
    //     child: Center(
    //       child: FutureBuilder(
    //         future: readToDo(),
    //         builder: (context, snapshot) {
    //           // final data = snapshot.data!;
    //           // String? data = snapshot.data!;
    //           // print(data);

    //           if (snapshot.hasData) {
    //             return ListView.builder(
    //                 itemCount: snapshot.data.length,
    //                 itemBuilder: (context, index) {
    //                   final data = snapshot.data[index];
    //                   print(data);
    //                   return ListTile(
    //                     title: Text(data["todo"].toString()),
    //                     trailing: IconButton(
    //                       icon: const Icon(Icons.delete),
    //                       onPressed: () async {
    //                         final id = [data["id"]];
    //                         // print(id);
    //                         await deleteToDo(id: id).then(
    //                           (value) {
    //                             ScaffoldMessenger.of(context).showSnackBar(
    //                               SnackBar(
    //                                 content: Text("Task  Deleted"),
    //                               ),
    //                             );
    //                           },
    //                         );
    //                         setState(() {});
    //                       },
    //                     ),
    //                   );
    //                 });
    //           } else {
    //             return const Text("Please Add Todo");
    //           }

    //           // return Text("okok");
    //           // final data = snapshot.data;
    //           // if (snapshot.hasData) {
    //           //   return ListView.builder(
    //           //     itemCount: snapshot.data.length,
    //           //     itemBuilder: (context, index) {
    //           //       final data = snapshot.data[index]!;
    //           //       print(data);
    //           //       return ListTile(
    //           //         title: Text("JRIOJW"),
    //           //   trailing: IconButton(
    //           //     icon: const Icon(Icons.delete),
    //           //     onPressed: () {},
    //           //   ),
    //           // );
    //           //     },
    //           //   );
    //           // } else {
    //           //   return const Text("Please Add Todo");
    //           // }
    //         },
    //       ),
    //     ),
    //   ),