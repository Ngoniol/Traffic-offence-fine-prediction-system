import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/reset_values.dart';
import '../screens/login.dart';
import '../screens/notifications.dart';

class App extends StatelessWidget implements PreferredSizeWidget {

  const App({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: const Text("Traffic"),
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
            onPressed: () async {
              Navigator.popUntil(context, (route) => false);
              await FirebaseAuth.instance.signOut().then((value) {
                resetValues();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login())
                );
              });
            }
        ),

      ],
    );
  }
}
