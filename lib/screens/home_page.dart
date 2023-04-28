import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/reusable_widgets/reusable_widgets.dart';
import 'package:project/reusable_widgets/side_navbar.dart';
import 'package:project/screens/register_offence.dart';
import '../reusable_widgets/app_bar.dart';


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
      appBar: const App(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.height * 0.2,10,0,0),
            child: Column(
              children: [
                functionButton(context, 'Register offence', 0xFF1D438C,(){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const RegOffence()));
                })
              ],
            )
          ),
        ]

      ),
    );
  }
}
