import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget{
  @override
  AddTaskPageState createState()=>AddTaskPageState();
}

class AddTaskPageState extends State<AddTaskPage>{
  TextEditingController taskController = TextEditingController(); //reads user input
//textcontrol allows u to read text,clear text and set text
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Add Task")),
      body : Padding( //adds space so that text doesnt touch screen edge
        padding: EdgeInsets.all(16),
        child : Column(children: [
          TextField(
            controller: taskController, //controls text inside textfield
            decoration: InputDecoration(
              labelText: "Task Name",
              border : OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 20), //vertical gap
          ElevatedButton(
            onPressed:(){
              String newTask = taskController.text;

              Navigator.pop(context,newTask);//nvaigator manages the stack of screens
            },
            child : Text("Save Task"),
            )
        ],)
        )
      );
  }
}