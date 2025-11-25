import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget{
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(), 
      password: passwordController.text.trim(),
      );

      Navigator.pushReplacementNamed(context, "/home");
    }
    catch(e){
      print("LOGIN ERROR:$e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> register() async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(), 
      password: passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context,"/home"); //moves to homepage on login  
    }
    catch(e){
      print("REGISTER ERROR :$e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 20),

            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: login,
              child: Text("Login"),
              ),
            ElevatedButton(
              onPressed: register , 
              child: Text("Register"),
              ),
          ],
        ),
      ),
    );
  }
}