import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/util/dbhelper.dart';
import 'package:todo_app/screens/todolist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    /************** code to Test the working of CRUD operations :- *************/

    // List<Todo> todos = List<Todo>();+
    // DbHelper helper = DbHelper();

    // // first we want to read the todos in the db.
    // // the first time it will be empty but the seconf time it will contain TODO which we will insert.
    // helper
    //     .initializeDb()
    //     .then((result) => helper.getTodos().then((result) => todos = result));

    // DateTime today = DateTime.now();
    // Todo todo = Todo("Assignment", 3, today.toString(),
    //     "will complete from tomorrow)");
    // var result = helper.insertTodo(todo);

    /****************************************************************************/



    return MaterialApp(
      title: 'Todos',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Todos'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: TodoList(),
    );
  }
}
