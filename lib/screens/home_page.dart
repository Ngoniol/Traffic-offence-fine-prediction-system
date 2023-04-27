import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/screens/login.dart';
import 'package:project/reusable_widgets/side_navbar.dart';
import 'package:project/screens/notifications.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Stream<QuerySnapshot> officer =
  FirebaseFirestore.instance.collection('officer').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  SideNav(),
      appBar: AppBar(title: const Text("Traffic"),
      backgroundColor: const Color(0xFF1D438C),
      toolbarHeight: 70,
      actions: [
        IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Notifications())
                );
              });
            }
        ),
        IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.popUntil(context, (route) => false);
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login())
                );
              });
            }
        ),

        ],
      ),
    );
  }
}
