// This class will show a screen of detail of a particular todo

import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/util/dbhelper.dart';
import 'package:intl/intl.dart'; // To wrtie the date of our todo in the format we choose

class TodoDetail extends StatefulWidget {
  final Todo todo;
  TodoDetail(this.todo);

  @override
  State<StatefulWidget> createState() => TodoDetailState(todo);
}

class TodoDetailState extends State {
  Todo todo;

  // Constructor to initialize the particular todoDetail
  TodoDetailState(this.todo);
  final _priorities = ["High", "Medium", "Low"];
  String _priority = "Low";
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // if there is data already, then show it
    titleController.text = todo.title;
    descriptionController.text = todo.description;
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // to hide back button on appBar
        title: Text(todo.title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: titleController,
            style: textStyle,
            decoration: InputDecoration(
              labelText: "Title",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          TextField(
            controller: descriptionController,
            style: textStyle,
            decoration: InputDecoration(
              labelText: "Decription",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          DropdownButton<String>(
            items: _priorities.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            style: textStyle,
            value: "Low",
            onChanged: null,
          ),
        ],
      ),
    );
  }
}
