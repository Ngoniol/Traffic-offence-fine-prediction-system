import 'package:flutter/material.dart';
import 'package:project/reusable_widgets/reusable_widgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailTextController = TextEditingController();
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
                    Text("Forgot Password"),
                    SizedBox(
                      height: 30,
                    ),
                    reusableTextField("Enter email", Icons.email_outlined, false, _emailTextController),
                    loginButton(context, false, () {})
                  ],
                ),
              )
          ),
        )
    );
  }
}