import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/util/dbhelper.dart';
import 'package:todo_app/screens/tododetail.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoListState();
}

class TodoListState extends State {
  DbHelper helper = DbHelper(); // To retrive data
  List<Todo> todos;
  int count = 0; // No. of records in the db

  @override
  Widget build(BuildContext context) {
    // When the screen is loaded first time
    if (todos == null) {
      todos = List<Todo>();
      getData(); // set the todos and count class properties.
    }
    return Scaffold(
      body: todoListItems(), // gets the ListView widget
      floatingActionButton: FloatingActionButton(
        onPressed: () { // adding a new Todo. 
          navigateToDetail(Todo('', 3, '')); // Setting initial priority as low.
        },
        tooltip: "Add new Todo",
        child: new Icon(Icons.add),
      ),
    );
  }

  // Showing the currently stored Todo.
  ListView todoListItems() {
    return ListView.builder( // This will automatically adjust the space using scrolling feature.
      // ListView is constructed with a builder method.
      itemCount: count,
      // itemBuilder takes a function which is iterated over each item in the List
      itemBuilder: (BuildContext context, int position) {
        // Card is sheet of material with slightly rounded corners and shadow.
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile( // listTile will let the dropdown takes all the horizontal space on the screen.
            leading: CircleAvatar(
              backgroundColor: getColor(this.todos[position].priority),
              child: Text(
                this.todos[position].priority.toString(),
              ),
            ),
            title: Text(this.todos[position].title),
            subtitle: Text(this.todos[position].date),
            // When the user taps on the todo.
            onTap: () {
              debugPrint("Tapped on " + this.todos[position].id.toString());
              navigateToDetail(this.todos[position]);
            },
          ),
        );
      },
    );
  }

  // This method will return void but use the setState method
  // to update the todos and count properties of our class
  void getData() {
    final dbFuture = helper.initializeDb();
    // Get the database or initialize it if it doesnot exist.
    // dbFuture contains the future of db and not the db itself.

    dbFuture.then((result) {
      // the then() will be executed only when the db is successfuly opened.
      // The then() will inject a result which is db in our case.
      final todosFuture = helper.getTodos();
      todosFuture.then((result) {
        List<Todo> todolist = List<Todo>();
        count = result.length;
        for (int i = 0; i < count; i++) {
          todolist.add(Todo.fromObject(
              result[i])); // This will transform a generic object into a Todo
          debugPrint(todolist[i].title);
        }
        setState(() {
          todos = todolist;
          count = count;
        });
        debugPrint("Items " + count.toString()); 
        // Will print only in the debug window.
      });
    });
  }

  // Getting color of priority.
  Color getColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.orange;
        break;
      case 3:
        return Colors.green;
        break;
      default:
        return Colors.green;
    }
  }

  void navigateToDetail(Todo todo) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoDetail(todo)), // the builder of MaterialPageRoute will call the TodoDetail class passing the todo that was passed.
    );
    if(result == true){ // when the operation succeeds.
      getData();
    }
  }
}
