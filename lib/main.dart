// import 'package:flutter/material.dart';

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
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {

//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(

//         title: Text(widget.title),
//       ),
//       body: Center(

//         child: Column(

//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:db__sqflite/models/todo_models.dart';
import 'package:db__sqflite/services/database_helper.dart';
// import 'package:db_sqflite_/model/todo_Model.dart';
// import 'package:db_sqflite_/services/database_helper.dart';

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
  //Textfotmfied controller
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
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
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: FutureBuilder(
            future: readToDo(),
            builder: (context, snapshot) {
              // final data = snapshot.data!;
              // String? data = snapshot.data!;
              // print(data);

              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data[index];
                      //print(data);
                      return ListTile(
                        title: Text(data["todo"].toString()),  //"todo" is the name of the database table
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            final id = [
                              //A list of id is needed so wrap in a  [] to get that
                              data["id"]
                            ];                         
                            await deleteToDo(id: id).then(
                              (value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Task  Deleted"),
                                  ),
                                );
                              },
                            );
                            setState(() {});
                          },
                        ),
                      );
                    });
              } else {
                return const Text("Please Add Todo");
              }

              // return Text("okok");
              // final data = snapshot.data;
              // if (snapshot.hasData) {
              //   return ListView.builder(
              //     itemCount: snapshot.data.length,
              //     itemBuilder: (context, index) {
              //       final data = snapshot.data[index]!;
              //       print(data);
              //       return ListTile(
              //         title: Text("JRIOJW"),
              //   trailing: IconButton(
              //     icon: const Icon(Icons.delete),
              //     onPressed: () {},
              //   ),
              // );
              //     },
              //   );
              // } else {
              //   return const Text("Please Add Todo");
              // }
            },
          ),
        ),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
