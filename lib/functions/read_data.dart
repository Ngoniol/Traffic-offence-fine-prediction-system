import 'package:cloud_firestore/cloud_firestore.dart';

//initializing variables
String firstName = '';
String surname = '';
String email = '';
String phoneNumber = '';
String badgeNumber = '';
String imageURL = '';
String userRole = '';

Future<void> getUserData(String userEmail) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: userEmail)
      .limit(1)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    final documentSnapshot = querySnapshot.docs.first;
    final data = documentSnapshot.data();
    firstName = data['firstName'] ?? '';
    surname = data['surname'] ?? '';
    email = data['email'] ?? '';
    phoneNumber = data['phoneNumber'] ?? '';
    userRole = data['userRole'] ?? '';
    badgeNumber = data['badgeNumber'] ?? '';
    imageURL = data['imageURL'] ?? '';
  } else {
    print('Document does not exist!');
  }
}