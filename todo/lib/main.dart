import 'package:flutter/material.dart'; //provides widgets like scaffold,text etc

void main() {
  runApp(MyApp());    //like launch(args)
}

class MyApp extends StatelessWidget{  //stateless eg "hello" that doesnt need to change
  @override //theres always a build func for every widget
  Widget build(BuildContext context){ //build tells Flutter WHAT to show on screen
    return MaterialApp(   //buildcontext gives the location in widget tree eg who is the parent etc
      title:'ToDo',     //like the address
      home:TaskPage(),
    );
  }
}

class TaskPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Text('Tasks')),
      body: Center(child:(Text('Your tasks will be here'))),
    );
  }
}
