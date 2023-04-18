import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/login.dart';
import 'package:project/reusable_widgets/side_navbar.dart';
import 'package:project/screens/notifications.dart';


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
      appBar: AppBar(title: const Text("Traffic"),
      backgroundColor: Color(0xFF1D438C),
      toolbarHeight: 70,
      actions: [
        IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Notifications())
                );
              });
            }
        ),
        IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
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
