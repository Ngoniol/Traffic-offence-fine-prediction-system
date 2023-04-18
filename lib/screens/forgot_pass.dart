import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/reusable_widgets/reusable_widgets.dart';
import 'package:project/screens/login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Color(0xFF1D438C)
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("./images/logo.png",
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.height * 0.2,
                    ),
                    const Text("Reset Password", style: TextStyle(color: Colors.white, fontSize: 20),),
                    const SizedBox(
                      height: 5,
                    ),
                    login(),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter email", Icons.email_outlined, false, _emailTextController),
                    const SizedBox(
                      height: 10,
                    ),
                    functionButton(context, "Reset Password", () {
                      FirebaseAuth.instance.sendPasswordResetEmail(email: _emailTextController.text).then(
                              (value) => Navigator.of(context).pop()).onError((error, stackTrace) {
                                print("Error: ${error.toString()}");
                      });
                    }),
                  ],
                ),
              )
          ),
        )
    );
  }

  Row login(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Login()));
          },
          child: const Text("Login",
              style: TextStyle(color: Color.fromARGB(255, 4, 157, 228))),
        )
      ],
    );
  }
}