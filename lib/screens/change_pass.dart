import 'package:flutter/material.dart';
import 'package:project/reusable_widgets/reusable_widgets.dart';
import 'package:project/screens/login.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({Key? key}) : super(key: key);

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFF1D438C)
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("./images/logo.png",
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Text("Change Password", style: TextStyle(color: Colors.white, fontSize: 20),),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    reusableTextField("New password", Icons.lock_outline, true, _passwordTextController),
                    SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Confirm password", Icons.lock_outline, true, _passwordTextController),
                    SizedBox(
                      height: 10,
                    ),
                    functionButton(context, "Submit", () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    })
                  ],
                ),
              )
          ),
        )
    );
  }
  onTap(){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Login()));
  }
}

