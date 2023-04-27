import 'package:flutter/material.dart';
import 'package:project/screens/edit_details.dart';
import 'package:project/screens/home_page.dart';
import 'package:project/screens/register_offence.dart';
import '../functions/functions.dart';



class SideNav extends StatelessWidget {
   SideNav({Key? key}) : super(key: key);

  final String? displayEmail = getUserDetails();


  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('Olga Ngoni Test'),
              accountEmail: Text('$displayEmail'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset("./images/photo.jpg",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF1D438C),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined,),
            title: const Text("Home"),
            onTap: () {Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));},
          ),
          ListTile(
            leading: const Icon(Icons.book_outlined,),
            title: const Text("Register offence"),
            onTap: () {Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RegOffence()));},
          ),
          ListTile(
            leading: const Icon(Icons.settings,),
            title: const Text("Settings"),
            onTap: () {Navigator.push(context,
                MaterialPageRoute(builder: (context) => const EditDetails()));},
          ),
        ],
      )
    );
  }
}
