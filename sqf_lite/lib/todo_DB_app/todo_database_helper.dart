import 'package:path_provider/path_provider.dart';
import 'package:sqf_lite/todo_DB_app/todo_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:logger/logger.dart';

var logger = Logger();

//Create the sqflite database
Future createDatabase() async {
  logger.i('Creating DB');

  //Auto get the path the database storage and add our file path
  final directory = await getApplicationDocumentsDirectory();
  //logger.i(directory);
  return await openDatabase(
    '${directory.path}/todo',
    version: 1,
    onCreate: (db, version) {
      return db.execute('CREATE TABLE todo (id INTEGER PRIMARY KEY,todo TEXT)');
    },
  );
}

//Add Todo to Databse
Future<TodoModel> storeTodo({TodoModel? todo}) async {
  logger.i('Storing Todo to DB');
  //reference to the database in order to access it.
  final database = await createDatabase();
  //Insert data into the "todo" table; insert takes a map whhich in this case our Todo model returns
  database.insert(
    'todo',
    todo!.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  logger.i('Stored Todo to DB');
  //print(todo);
  return todo;
}

//Update Todo --not in use
Future<TodoModel> updateToDo({List? id, TodoModel? todo}) async {
  final database = await createDatabase();
  database.update(
    'todo',
    todo!.toMap(),
    where: "id =?",
    whereArgs: id,
  );

  return todo;
}

//Delete Todo - delete todo requires just a List [id]
//? is a reference identifier to represent the whereArgs value
Future deleteToDo({List? id}) async {
  logger.i('deleting Todo from DB');
  final database = await createDatabase();
  database.delete(
    'todo',
    where: "id =?",
    whereArgs: id,
  );
}

//Read Todo - Fetches content out of the Database Table
// Future readToDo() async {
//   logger.i('reading Todo from DB');
//   final database = await createDatabase();
//   return database.query("todo");
// }

//OR
Future<List<Map<String, Object?>>> readToDo() async {
  final database = await createDatabase();
  return database.query('todo');
}
