import 'package:flutter/material.dart';

//Main input fields
TextField reusableTextField(String text, IconData icon, bool isPasswordType,
TextEditingController controller) {
  return TextField(controller: controller,
  obscureText: isPasswordType,
  enableSuggestions: !isPasswordType,
  autocorrect: !isPasswordType,
  cursorColor: Colors.white,
  style:TextStyle(color: Colors.white.withOpacity(0.9)),
  decoration: InputDecoration(prefixIcon: Icon(icon, color: Colors.white70,),
  labelText: text,
  labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
  filled: true,
  floatingLabelBehavior: FloatingLabelBehavior.never,
  fillColor: Colors.white.withOpacity(0.3),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30.0),
    borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
  ),
  keyboardType: isPasswordType ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}

//Buttons that have functions
Container functionButton(
  BuildContext context, String buttonText, int colors, Function onTap) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 50,
      margin:const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black26;
              }
              return Color(colors);
            }),
          ),
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          )
    ),
  );
}

//Input fields
Widget buildTextField(String labelText, String placeholder, bool isPassword, TextEditingController controller){
  controller = controller;
  bool isObscurePassword = true;
  return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPassword ? isObscurePassword: false,
        decoration: InputDecoration(
          suffixIcon: isPassword ?
              IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.remove_red_eye,
                    color: Colors.grey,)
              ) : null,
            contentPadding: const EdgeInsets.only(bottom: 5),
            labelText: labelText,
            labelStyle: const TextStyle(
              fontSize: 18,
              color: Color(0xFF1D438C),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Colors.grey
            )
        ),
      ),
  );
}

//Edit button
Container editButton(
    BuildContext context, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.5,
    height: 30,
    margin:const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return const Color(0xFF1D438C);
          }),
        ),
        child: const Text(
          'Change password',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        )
    ),
  );
}