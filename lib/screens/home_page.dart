import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ElevatedButton(onPressed: () {
        FirebaseAuth.instance.signOut().then((value) {
          print("Signed out");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Login()));
        });
      }, child: const Text("Logout")),
    );
  }
}
