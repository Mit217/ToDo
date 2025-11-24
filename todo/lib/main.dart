import 'package:flutter/material.dart';
import 'package:todo/addtask_page.dart'; //provides widgets like scaffold,text etc

void main() {
  runApp(MyApp());    //like launch(args)
}

class MyApp extends StatelessWidget{  //stateless eg "hello" that doesnt need to change
  @override //theres always a build func for every widget
  Widget build(BuildContext context){ //build tells Flutter WHAT to show on screen
    return MaterialApp(   //buildcontext gives the location in widget tree eg who is the parent etc
      title:'ToDo',     //like the address
      home:HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  List<String> tasks=[];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Text('Tasks')),

      floatingActionButton: FloatingActionButton(
        onPressed:() async{
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=> AddTaskPage()),
            );

            if(result!=null && result.toString().trim().isNotEmpty){
              setState(() {
                tasks.add(result);
              });
            }
        },
        child: Icon(Icons.add),
        ),

        body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context,index){
            return ListTile(
              title: Text(tasks[index]),
            );
          },
        ),
    );
  }
}
