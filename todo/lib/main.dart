import 'package:flutter/material.dart';
import 'package:todo/addtask_page.dart';
import 'package:todo/login_page.dart'; //provides widgets like scaffold,text etc
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options : DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());    //like launch(args)
}

class MyApp extends StatelessWidget{  //stateless eg "hello" that doesnt need to change
  @override //theres always a build func for every widget
  Widget build(BuildContext context){ //build tells Flutter WHAT to show on screen
    return MaterialApp(   //buildcontext gives the location in widget tree eg who is the parent etc
      title:'ToDo',     //like the address
      home:AuthGate(),
      routes:{
        "/home":(context)=>HomePage(),
      }
    );
  }
}

class AuthGate extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context,snapshot){
        if(snapshot.hasData){
          return HomePage();
        }
        return LoginPage();
      },
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  List<String> tasks=[];  //normal array

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Text('Tasks')),

      floatingActionButton: FloatingActionButton(
        onPressed:() async{
          final result = await Navigator.push(   //opens task page and waits for data
            context,
            MaterialPageRoute(builder: (context)=> AddTaskPage()),
            );

            if(result!=null && result.toString().trim().isNotEmpty){
              setState(() {
                tasks.add(result);  //adds task to the list
              });
            }
        },
        child: Icon(Icons.add),
        ),

        body: ListView.builder(
          itemCount: tasks.length,  //shows task on screen one by one
          itemBuilder: (context,index){
            return ListTile(
              title: Text(tasks[index]),
              trailing: IconButton(
                icon : Icon(Icons.delete),
              onPressed:(){
                setState(() {
                  tasks.removeAt(index);
                });
              }
              ),
            );
          },
        ),
    );
  }
}
