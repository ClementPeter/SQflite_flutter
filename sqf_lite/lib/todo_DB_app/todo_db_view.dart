import 'package:flutter/material.dart';
import 'package:sqf_lite/todo_DB_app/todo_database_helper.dart';
import 'package:sqf_lite/todo_DB_app/todo_model.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key, required this.title});

  final String title;

  @override
  State<TodoPage> createState() => TodoPageState();
}

class TodoPageState extends State<TodoPage> {
  //Textformfied controller
  final TextEditingController _searchController = TextEditingController();

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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SearchBar(
                  controller: _searchController,
                  hintText: "Add data To Sqlflite DB",
                  trailing: [
                    InkWell(
                      child: const Icon(Icons.send),
                      onTap: () async {
                        if (_searchController.text.isEmpty) {
                          return;
                        } else {
                          final text = _searchController.text.trim();
                          final newTodo = TodoModel(todo: text);

                          //Add Todo need a type of Todo
                          await storeTodo(todo: newTodo);

                          setState(
                            () {
                              _searchController.clear();
                            },
                          );
                        }
                      },
                    ),
                  ],
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
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data![index];
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
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Todo Deleted from Sqflite local storage",
                                    ),
                                  ),
                                );
                                //setState(() {}); //SetState Would also work here
                              },
                            );
                            setState(() {});
                          },
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
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
