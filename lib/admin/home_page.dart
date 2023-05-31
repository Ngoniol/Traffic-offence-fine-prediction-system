import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/charts/bar_graph.dart';
import 'package:project/reusable_widgets/side_navbar.dart';
import '../reusable_widgets/app_bar.dart';


class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHome();
}

class _AdminHome extends State<AdminHome> {
  final Stream<QuerySnapshot> officer =
  FirebaseFirestore.instance.collection('officer').snapshots();
  @override
  List<double> weeklySymmary = [
    4.40,
    2.50,
    42.42,
    10.50,
    100.20,
    88.99,
    90.10,
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  SideNav(),
      appBar: const App(),
      body: Center(
        child: SizedBox(
          height: 400,
          child: MyBarGraph(
            weeklySummary: weeklySymmary,
          ),
        ),
      )
    );
  }
}
