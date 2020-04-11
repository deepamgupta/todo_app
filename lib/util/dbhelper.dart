// "Data is the king"
import 'package:sqflite/sqflite.dart'; //This is the guest of honour.
import 'dart:async';
import 'dart:io'; // To get directoryof database
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/model/todo.dart';

// We need the instance of this class only once
class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();
  String tblTodo = "todo";
  String colId = "id";
  String colTitle = "title";
  String colDescription = "description";
  String colPriority = "priority";
  String colDate = "date";

  DbHelper._internal();

  // The factory keyboard is responsible fo rthe class to be singleton.
  factory DbHelper() {
    return _dbHelper;
  }

  // This will contain our database whole throughout.
  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  // A Future is used to represent a potential value or
  // error that will be available at sometime in the future,
  // it is from the async package.

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    // Directory is from the io package.
    // getApplicationDocumentsDirectory method is from the path_provider package.
    // dir will await the getApplicationDocumentsDirectory() method.
    // getApplicationDocumentsDirectory() will return the directoy for the documents of our app.
    // The path are different in iOS and Android but this will work in any case.

    String path = dir.path + "todos.db";
    var dbTodos = await openDatabase(path, version: 1, onCreate: _createDb);
    // onCreate specifies what to do if the database does not exists.
    return dbTodos;
  }

  // This method will launch the sql query to create a db.
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblTodo($colId INTEGER PRIMARY KEY, $colTitle TEXT, " +
            "$colDescription TEXT, $colPriority INTEGER, $colDate TEXT");
  }

  // If tsomething went wrong, this will return a 0 else, it will return the id of the record inserted.
  Future<int> insertTodo(Todo todo) async {
    Database db = await this.db;
    var result = await db.insert(tblTodo, todo.toMap());
    return result;
  }

  Future<List> getTodos() async {
    Database db = await this.db;
    var result =
        await db.rawQuery("select * from $tblTodo order by $colPriority asc");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("select count (*) from $tblTodo"));
    return result;
  }

  Future<int> updateTodo(Todo todo) async {
    var db = await this.db;
    var result = await db.update(tblTodo, todo.toMap(),
        where: "$colId = ?",
        whereArgs: [
          todo.id
        ]); // whereArgs is an array as it can contain multiple values.
    return result;
  }

  Future<int> deleteTodo(int id) async {
    var db = await this.db;
    // var result = await db.delete(tblTodo, where: "$colId = ?", whereArgs: [id]);
    var result = await db.rawDelete("delete from $tblTodo where $colId = $id");
    return result;
  }
}
