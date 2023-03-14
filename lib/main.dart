import 'package:flutter/material.dart';
import 'package:db__sqflite/todoDB/models/todo_model.dart';
import 'package:db__sqflite/todoDB/services/todo_database_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'SQFLITE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Textformfied controller
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 199, 199, 199),
                ),
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Add data To Sqlflite DB",
                    border: InputBorder.none,
                    suffixIcon: InkWell(
                      child: const Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),
                      onTap: () async {
                        print("tapped");

                        if (_controller.text.isEmpty) {
                          return;
                        } else {
                          final text = _controller.text.trim();
                          final newTodo = TodoModel(todo: text);

                          //Add Todo need a type of Todo
                          await addTodo(todo: newTodo).then(
                            (value) {
                              //Clear text field after add todo to DB
                              setState(
                                () {
                                  _controller.clear();
                                },
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: FutureBuilder(
            future: readToDo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        tileColor: const Color.fromARGB(255, 211, 210, 210),
                        title: Text(
                          data["todo"].toString(),
                        ), //"todo" is the name of the database table
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            //A list of id is needed so wrap in a  [] to get that
                            final id = [data["id"]];
                            //awaiting  deleteTodo make all the Todoask delete at once
                            deleteToDo(id: id).then(
                              (value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Todo Deleted from Sqflite local storage"),
                                  ),
                                );
                                //setState(() {}); //SetState Would also work here
                              },
                            );
                            setState(() {});
                          },
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text("Please Add Todo"));
              }
            },
          ),
        ),
      ),
    );
  }
}

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

//Local Storage with Sqlite

// This recipe uses the following steps:

// Add the dependencies. - sdflite and path
// Define the Dog data model.
// Open the database.
// Create the dogs table.
// Insert a Dog into the database.
// Retrieve the list of dogs.
// Update a Dog in the database.
// Delete a Dog from the database.

// import 'dart:async';
// import 'package:db__sqflite/dogsDB/dog_model/dogModel.dart';
// import 'package:flutter/widgets.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:flutter/material.dart';
// import 'package:db__sqflite/todoDB/models/todo_model.dart';
// import 'package:db__sqflite/todoDB/services/todo_database_helper.dart';

// import 'dogsDB/dog_model/dog_database_helper/dog_database_helper.dart';

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
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'SQFLITE'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   //Textformfied controller
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _idController = TextEditingController();

//   DogDB  dogDB = DogDB();

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
//                               print(
//                                   ":::::::::Please fill all the fields::::::::");
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
//                                   ":::::::::BEFORE Dog data inserted but not showing yet::::::::");

//                               //PRINT DOG MODEL
//                               print(":::::::::::$dogData:::::::::::::");

//                               // await insertDog(dogData);

//                               print(
//                                   ":::::::::Dog data inserted but not showing yet::::::::");

//                               setState(
//                                 () async {
//                                   await dogDB.
//                                   print(":::::::::Dog data inserted::::::::");
//                                 },
//                               );

//                               // //Add Todo need a type of Todo
//                               // await insertDog(dogData).then(
//                               //   (value) {
//                               //     //Clear text field after add todo to DB
//                               //     setState(
//                               //       () {
//                               //         _nameController.clear();
//                               //         _ageController.clear();
//                               //         _idController.clear();
//                               //       },
//                               //     );
//                               print(
//                                   ":::::::::Dog data inserted but not showing yet::::::::");
//                               //   },
//                               // );
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
//               //padding: const EdgeInsets.symmetric(horizontal: 100),
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
//             future: retrieveDogData(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return ListView.builder(
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) {
//                     final data = snapshot.data[index];
//                     return Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: ListTile(
//                         tileColor: const Color.fromARGB(255, 211, 210, 210),
//                         title: Text(
//                           data["dogs"].toString(),
//                         ), //"todo" is the name of the database table
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             //A list of id is needed so wrap in a  [] to get that
//                             //final id = [data["id"]];
//                             final id = data[index].id;
//                             //awaiting  deleteTodo make all the Todoask delete at once
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
//                 return const Center(child: Text("Please Add Todo"));
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
