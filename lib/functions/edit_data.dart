import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/functions/read_data.dart';


changePassword() {
  FirebaseAuth.instance.sendPasswordResetEmail(email: email);
}

