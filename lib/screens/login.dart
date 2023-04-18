import 'package:flutter/material.dart';
import 'package:project/reusable_widgets/reusable_widgets.dart';
import 'forgot_pass.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _passwordTextController = TextEditingController();
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
              SizedBox(
                height: 30,
              ),
              reusableTextField("Enter email", Icons.email_outlined, false, _emailTextController),
              SizedBox(
                height: 30,
              ),
              reusableTextField("Enter password", Icons.lock_outline, true, _passwordTextController),
              SizedBox(
                height: 20,
              ),
              forgotPassword(),
              loginButton(context, true, () {})
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
            MaterialPageRoute(builder: (context) => ForgotPassword()));
          },
          child: const Text("Forgot password?",
        style: TextStyle(color: Color.fromARGB(255, 4, 157, 228))),
        )
      ],
    );
  }
}