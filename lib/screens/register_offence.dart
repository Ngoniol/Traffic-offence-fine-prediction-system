import 'package:flutter/material.dart';
import '../reusable_widgets/app_bar.dart';
import '../reusable_widgets/side_navbar.dart';

class RegOffence extends StatefulWidget {
  const RegOffence({Key? key}) : super(key: key);

  @override
  State<RegOffence> createState() => _RegOffenceState();
}

class _RegOffenceState extends State<RegOffence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  SideNav(),
      appBar: const App(),
    );
  }
}
