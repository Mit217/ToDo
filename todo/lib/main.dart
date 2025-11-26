import 'package:flutter/material.dart';
 //provides widgets like scaffold,text etc
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';
import 'package:todo/addtask_page.dart';
import 'package:todo/login_page.dart';
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
  @override
  Widget build(BuildContext context){
    final uid = FirebaseAuth.instance.currentUser!.uid;
    
    return Scaffold(
      appBar: AppBar(
        title:Text('Tasks'),
        actions:[
          IconButton(
            icon : Icon(Icons.logout),
            onPressed:(){
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child : Icon(Icons.add),
        onPressed:() async{
          final task = await Navigator.push(   //opens task page and waits for data
            context,
            MaterialPageRoute(builder: (context)=> AddTaskPage()),
            );

            if(task!=null && task.toString().trim().isNotEmpty){
                await FirebaseFirestore.instance  //adds task to the list
                  .collection("tasks")
                  .add({
                    "task":task,
                    "uid":uid,
                    "createdAt":Timestamp.now(),
                    "isDone":false,
                });
              }
            },
          ),

        body: StreamBuilder(
          stream: FirebaseFirestore.instance
            .collection("tasks")
            .where("uid",isEqualTo:uid)
            .orderBy("isDone")
            .orderBy("createdAt")
            .snapshots(),   //for live updates
          builder:(context,snapshot){ //streambuilder listens to firestore like radio
            if(!snapshot.hasData) //snapshot contains the latest firestore data
              return Center(child:CircularProgressIndicator());
          
            final docs = snapshot.data!.docs; //docs is a list of all the tasks

            if (docs.isEmpty){
              return Center(child: Text("No tasks yet!"));
            }

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context,index){
                  final taskData=docs[index];
                  final isDone = taskData["isDone"]??false;

                return AnimatedOpacity(
                  opacity: isDone? 0.4:1.0,
                  duration: Duration(milliseconds: 300),
                  child : ListTile(
                    leading: Checkbox(
                      value: isDone,
                      onChanged:(bool? value) async{
                        await FirebaseFirestore.instance
                          .collection("tasks")
                          .doc(taskData.id)
                          .update({"isDone": value??false});
                          setState(() {});
                      },
                    ), 
                                        
                    title: Text(
                      taskData["task"],
                      style: TextStyle(
                        decoration: isDone
                          ?TextDecoration.lineThrough
                          :TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon : Icon(Icons.delete),
                      onPressed:(){
                        FirebaseFirestore.instance
                          .collection("tasks")
                          .doc(taskData.id)
                          .delete();
                      }, 
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    }
  }

