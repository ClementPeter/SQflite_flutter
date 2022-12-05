import 'package:flutter/material.dart';
import 'package:db__sqflite/models/todo_models.dart';
import 'package:db__sqflite/services/database_helper.dart';

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
                                    content: Text("Todo Deleted"),
                                  ),
                                );
                                //setState(() {}); //SetState Would also work here
                              },
                            );
                            setState(() {});
                          },
                        ),
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
