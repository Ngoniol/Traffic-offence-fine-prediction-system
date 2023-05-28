import 'package:flutter/material.dart';
import 'package:project/functions/read_data.dart';
import 'package:project/screens/home_page.dart';
import 'package:project/screens/register_offence.dart';
import 'package:project/screens/user_profile.dart';

class SideNav extends StatelessWidget {
   const SideNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //Display data from the logged in user
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('$fname $sname'),
              accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(imageURL,
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

          //Go to homepage
          ListTile(
            leading: const Icon(Icons.home_outlined,),
            title: const Text("Home"),
            onTap: () {Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));},
          ),

          //Go to register an offense page
          ListTile(
            leading: const Icon(Icons.book_outlined,),
            title: const Text("Register offence"),
            onTap: () {Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RegOffence()));},
          ),

          //View and edit user details
          ListTile(
            leading: const Icon(Icons.person,),
            title: const Text("User Profile"),
            onTap: () {Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UserProfile()));},
          ),
        ],
      )
    );
  }
}
