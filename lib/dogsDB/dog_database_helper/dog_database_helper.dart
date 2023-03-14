// import 'package:db__sqflite/dogsDB/dog_model/dogModel.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:flutter/widgets.dart';

// //WidgetsFlutterBinding.ensureInitialized();

// dogDataBase() async {
//   //open the database with "openDatabase" function

//   //get the path dir of the Database -> create DB -> Specify verison
//   final database = openDatabase(
//     join(await getDatabasesPath(), "doggie_database.db"),

//     //Using the dogModel ;
//     // id is an INT and is stored in the INTEGER DATATYPE  SQLite Datatype - Use ID as PRIMARY KEY (GoodPractice)
//     // name is a Dart String, stored in a TEXT SQLite Datatype.
//     // age is also an int, stored as an INTEGER Datatype.

//     //id, name, age are the column label of the DB;
//     //they would represent our keys for our "Map" from dogModel "toMap" function
//     //Note our TABLE name here is  "dogs"
//     onCreate: (db, version) {
//       return db.execute(
//         'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER )',
//       );
//     },
//     // Set the version. This executes the onCreate function and provides a
//     // path to perform database upgrades and downgrades.
//     version: 1,
//   );
// }

// // Define a function that inserts dogs into the database
// Future insertDog(DogModel dog) async {
//   // Get a reference to the database.
//   final db = await dogDataBase();

//   // Insert the Dog into the correct table. You might also specify the
//   // `conflictAlgorithm` to use in case the same dog is inserted twice.
//   //
//   // In this case, replace any previous data.

//   db.insert("dogs", dog.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

//   print("::::::::::::Dog Added to DB:::::::::::::");

//   return dog;

//   //////
//   /////Now add /a Dog called wisky to the DB

//   //try changing the type to Dog

//   // var wisky = DogModel(
//   //   id: 0,
//   //   name: "wisky",
//   //   age: 10,
//   // );

//   // await insertDog(wisky);
// }

// //Retrieving Data for our "Dogs" database
// Future retrieveDogData() async {
//   // Get a reference to the database.
//   final db = await dogDataBase();

//   // Query the table for all The Dogs.
//   //final List<Map<String, dynamic>> maps = await db.query("dogs");

//   //Convert the Map from our DB to a List
//   // return List.generate(maps.length, (index) {
//   //   return DogModel(
//   //     id: maps[index]['id'],
//   //     name: maps[index]["name"],
//   //     age: maps[index]["age"],
//   //   );
//   // });

//   return db.query("dogs");
// }

// // Now, use the method above to retrieve all the dogs.
// //print(await dogs()); // Prints a list that include Fido.

// ////Update the given Dog
// //Convert the Dog into a Map.
// //Use a where clause to ensure you update the correct Dog.
// Future<void> updateDog(DogModel dog) async {
//   // Get a reference to the database.
//   final db = await dogDataBase();

//   // Ensure that the Dog has a matching id.
//   // Pass the Dog's id as a whereArg to prevent SQL injection.

//   db.update("dogs", dog.toMap(), where: "id =?", whereArgs: [dog.id]);

//   /////
//   ///
// //update Wisky's age and save to database

// //  var wisky = Dog(
// //   id : wisky.id,
// //   name: wisky.name,
// //   age: wisky.age + 10,
// // );

// //await updateDog(wisky);

//   //print(await retrieveDogData()); // Prints Fido with age 20.
// }

// // Warning: Always use whereArgs to pass arguments to a where statement.
// // This helps safeguard against SQL injection attacks.

// //Deleting Dog form Database

// Future<void> deleteDog(int id) async {
//   // Get a reference to the database.
//   final db = await dogDataBase();

//   db.delete('dog', where: "id =?", whereArgs: [id]);
// }

///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///

// import 'dart:async';

// import 'package:db__sqflite/dogsDB/dog_model/dogModel.dart';
// import 'package:flutter/widgets.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DogDB {
//   //WidgetsFlutterBinding.ensureInitialized();

//   dogModelDataBase() async {
//     //open the database with "openDatabase" function

//     //get the path dir of the Database -> create DB -> Specify verison
//     final database = openDatabase(
//       join(await getDatabasesPath(), "DogModelgie_database.db"),

//       //Using the DogModelModel ;
//       // id is an INT and is stored in the INTEGER DATATYPE  SQLite Datatype - Use ID as PRIMARY KEY (GoodPractice)
//       // name is a Dart String, stored in a TEXT SQLite Datatype.
//       // age is also an int, stored as an INTEGER Datatype.

//       //id, name, age are the column label of the DB;
//       //they would represent our keys for our "Map" from DogModelModel "toMap" function
//       //Note our TABLE name here is  "DogModels"
//       onCreate: (db, version) {
//         return db.execute(
//           'CREATE TABLE DogModels(id INTEGER PRIMARY KEY, name TEXT, age INTEGER )',
//         );
//       },
//       // Set the version. This executes the onCreate function and provides a
//       // path to perform database upgrades and downgrades.
//       version: 1,
//     );
//   }

//   // Define a function that inserts DogModels into the database
//   Future insertDogModel(DogModel DogModel) async {
//     // Get a reference to the database.

//     final db = await dogModelDataBase();

//     // Insert the DogModel into the correct table. You might also specify the
//     // `conflictAlgorithm` to use in case the same DogModel is inserted twice.
//     //
//     // In this case, replace any previous data.

//     db.insert("DogModels", DogModel.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   //Retrieving Data for our "DogModels" database
//   Future retrieveDogModelData() async {
//     // Get a reference to the database.
//     final db = await dogModelDataBase();

//     // Query the table for all The DogModels.
//     final List<Map<String, dynamic>> maps = await db.query("DogModels");

//     //Convert the Map from our DB to a List
//     return List.generate(maps.length, (index) {
//       return DogModel(
//         id: maps[index]['id'],
//         name: maps[index]["name"],
//         age: maps[index]["age"],
//       );
//     });

//     // return db.query("DogModels");
//   }

//   ////Update the given DogModel
//   //Convert the DogModel into a Map.
//   //Use a where clause to ensure you update the correct DogModel.
//   Future<void> updateDogModel(DogModel DogModel) async {
//     // Get a reference to the database.
//     final db = await dogModelDataBase();

//     // Ensure that the DogModel has a matching id.
//     // Pass the DogModel's id as a whereArg to prevent SQL injection.

//     db.update("DogModels", DogModel.toMap(),
//         where: "id =?", whereArgs: [DogModel.id]);
//   }

//   // Warning: Always use whereArgs to pass arguments to a where statement.
//   // This helps safeguard against SQL injection attacks.

// //Deleting DogModel form Database
//   Future<void> deleteDogModel(int id) async {
//     // Get a reference to the database.
//     final db = await dogModelDataBase();

//     db.delete('DogModel', where: "id =?", whereArgs: [id]);
//   }

//   //
//   //
//   //
//   //
//   //
//   //
//   //
//   //
//   //
//   //
//   //

//   //::::::::::::::::::::USING THE DATABASE FUNCTIONS::::::::::::::::;;;;//

//   //Now add/insert a DogModel called wisky to the DB

// //   var wisky = DogModel(
// //     id: 0,
// //     name: "wisky",
// //     age: 10,
// //   );

// //   await insertDogModel(wisky);

// //   //Now, use the method above to retrieve the DogModels from the DB
// //   print(await retrieveDogModelData()); // Prints a list that include wISKY.

// //   //Update Wisky's age and save to database
// //   wisky = DogModel(
// //     id: wisky.id,
// //     name: wisky.name,
// //     age: wisky.age + 10,
// //   );

// //   await updateDogModel(wisky);

// //   print(await retrieveDogModelData()); // Prints wisky with age 20.

// //   await deleteDogModel(wisky.id);

// }












//