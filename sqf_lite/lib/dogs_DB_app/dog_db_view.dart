// /// Snippet 2 - Use this with "dog_database_helper" snippet 2
// /// Local Storage with Sqlite

// /// This recipe uses the following steps:

// /// Add the dependencies. - sqflite and path
// /// Define the Dog data model.
// /// Open the database.
// /// Create the dogs table.
// /// Insert a Dog into the database.
// /// Retrieve the list of dogs.
// /// Update a Dog in the database.
// /// Delete a Dog from the database.

// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:sqf_lite/dogs_DB_app/dogModel.dart';
// import 'package:sqf_lite/dogs_DB_app/dog_database_helper.dart';
// import 'package:sqf_lite/todo_DB_app/todo_database_helper.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         useMaterial3: true,
//       ),
//       home: const DogPage(title: 'SQFLITE'),
//     );
//   }
// }

// class DogPage extends StatefulWidget {
//   const DogPage({super.key, required this.title});

//   final String title;

//   @override
//   State<DogPage> createState() => _DogPageState();
// }

// class _DogPageState extends State<DogPage> {
//   //Textformfied controller
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _idController = TextEditingController();

//   DogDB dogDB = DogDB();

//   var logger = Logger();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(widget.title),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(50),
//           //container with gesture detector to open an alert dialog
//           child: InkWell(
//             onTap: () {
//               //show alert dialog
//               showDialog(
//                 context: context,
//                 builder: (context) {
//                   return AlertDialog(
//                     title: const Text("Dog Details"),
//                     content: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         TextFormField(
//                           controller: _nameController,
//                           decoration: const InputDecoration(
//                             hintText: "Dog name",
//                           ),
//                         ),
//                         TextFormField(
//                           controller: _ageController,
//                           decoration: const InputDecoration(
//                             hintText: "Dog age",
//                           ),
//                         ),
//                         TextFormField(
//                           controller: _idController,
//                           decoration: const InputDecoration(
//                             hintText: " Dog id",
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         ElevatedButton(
//                           onPressed: () async {
//                             if (_nameController.text.isEmpty &&
//                                 _ageController.text.isEmpty &&
//                                 _idController.text.isEmpty) {
//                               logger.e("Please fill all the fields");

//                               return;
//                             } else {
//                               final dogName = _nameController.text.trim();
//                               final dogAge = _ageController.text.trim();
//                               final dogId = _idController.text.trim();

//                               final dogData = DogModel(
//                                 age: int.parse(dogAge),
//                                 name: dogName,
//                                 id: int.parse(dogId),
//                               );

//                               print(
//                                   ":::::::::BEFORE: Dog data inserted, but not showing yet::::::::");

//                               //PRINT DOG MODEL
//                               print(":::::::::::$dogData:::::::::::::");

//                               print(
//                                   ":::::::::Dog data inserted but not showing yet::::::::");

//                               //await dogDB.insertDogModel(dogData);
//                               print(":::::::::Dog data inserted::::::::");

//                               await dogDB.insertDogModel(dogData);
//                               _nameController.clear();
//                               _ageController.clear();
//                               _idController.clear();
//                               print(":::::::::Dog data inserted::::::::");

//                               setState(() {});

//                               //     //Clear text field after add todo to DB
//                               // setState(
//                               //   () {
//                               //     _nameController.clear();
//                               //     _ageController.clear();
//                               //     _idController.clear();
//                               //   },
//                               // );

//                               /* using .then to resolve the future */

//                               // await dogDB.insertDogModel(dogData)
//                               // .then(
//                               //   (value) {
//                               //     //Clear text field after add todo to DB
//                               //     setState(
//                               //       () {
//                               //         _nameController.clear();
//                               //         _ageController.clear();
//                               //         _idController.clear();
//                               //       },
//                               //     );
//                               //     print(
//                               //         ":::::::::Dog data inserted but not showing yet::::::::");
//                               //   },
//                               // );

//                               logger.i('Dog data inserted');
//                               print(
//                                   ":::::::::Dog data inserted but not showing yet::::::::");
//                             }
//                           },
//                           child: const Text("Add Todo"),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             },
//             child: Container(
//               height: 30,
//               margin: const EdgeInsets.symmetric(horizontal: 100),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: const Color.fromARGB(255, 199, 199, 199),
//               ),
//               child: const Center(child: Text("Open Alert Dialog")),
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Center(
//           child: FutureBuilder(
//             future: dogDB.retrieveDogModelData(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return ListView.builder(
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) {
//                     //
//                     final data = snapshot.data[index];
//                     //
//                     return Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: ListTile(
//                         tileColor: const Color(0xFFD3D2D2),
//                         title: Text(
//                           data["dogs"].toString(),
//                         ), //"todo" is the name of the database table
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             ///A list of id is needed so wrap in a [] to get that
//                             ///final id = [data["id"]];
//                             final id = data[index].id;
//                             //awaiting deleteTodo make all the Todoask delete at once
//                             deleteToDo(id: id).then(
//                               (value) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content: Text(
//                                         "Todo Deleted from Sqflite local storage"),
//                                   ),
//                                 );
//                                 //setState(() {}); //SetState Would also work here
//                               },
//                             );
//                             setState(() {});
//                           },
//                         ),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8)),
//                       ),
//                     );
//                   },
//                 );
//               } else {
//                 return const Center(child: Text("Please Add Dog data"));
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
