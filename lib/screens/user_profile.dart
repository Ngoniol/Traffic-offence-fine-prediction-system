import 'package:flutter/material.dart';
import 'package:project/functions/edit_data.dart';
import 'package:project/functions/read_data.dart';
import '../reusable_widgets/app_bar.dart';
import '../reusable_widgets/reusable_widgets.dart';
import '../reusable_widgets/side_navbar.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool isEmail = false;
  bool isPhoneNumber = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  SideNav(),
      appBar: const App(),
      body: SingleChildScrollView(
        child:
        Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15, top: 20, right:15),
                child: ClipOval(
                  child: Image.network(
                      imageURL,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,0,20,0),
                child: Column(
                  children: [
                        buildTextField('Email address', email, false, _emailController),
                        buildTextField('Phone Number', phoneNumber, false, _phoneNumberController),
                        editButton(context,() => changePassword())
                  ],
                ),
              ),
            ]
        ),
      )
    );
  }
}
