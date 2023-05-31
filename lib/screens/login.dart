import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/admin/home_page.dart';
import 'package:project/functions/read_data.dart';
import 'package:project/reusable_widgets/reusable_widgets.dart';
import 'package:project/screens/home_page.dart';
import 'forgot_pass.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //initializing variables
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  String _errorMessage = '';
  bool _hasError = false;

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
              if (_hasError)
                Positioned(
                  left: 0,
                  right: 0,
                  top: -10,
                  child: Text(
                    _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 30,
              ),
              reusableTextField("Enter email", Icons.email_outlined, false, _emailTextController),
              const SizedBox(
                height: 30,
              ),
              reusableTextField("Enter password", Icons.lock_outline, true, _passwordTextController),
              const SizedBox(
                height: 20,
              ),
              forgotPassword(),

              //login function
              functionButton(context, "Login", 0XFF61759E,() {
                FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text).then((value) {
                      getUserData(_emailTextController.text);
                      Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const AdminHome()));
                }).onError((error, stackTrace) {
                  setState(() {
                    // Set the error message and error state
                    _errorMessage = error.toString().replaceAll(RegExp(r'\[.*\]\s*'), '');
                    _hasError = true;
                  });
                });
              })
            ],
          ),
        )
        ),
        )
    );
  }
  Row forgotPassword(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ForgotPassword()));
          },
          child: const Text("Forgot password?",
        style: TextStyle(color: Color.fromARGB(255, 4, 157, 228))),
        )
      ],
    );
  }
}