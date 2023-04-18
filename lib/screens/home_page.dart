import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/login.dart';
import 'package:project/reusable_widgets/side_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideNav(),
      appBar: AppBar(title: const Text("Traffic"),),
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
