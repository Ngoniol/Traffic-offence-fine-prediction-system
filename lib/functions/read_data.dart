import 'package:cloud_firestore/cloud_firestore.dart';

//initializing variables
String fname = '';
String sname = '';
String email = '';
String phoneNumber = '';
String badgeno = '';
String imageURL = '';

Future<void> getUserData(String userEmail) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('officer')
      .where('email', isEqualTo: userEmail)
      .limit(1)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    final documentSnapshot = querySnapshot.docs.first;
    final data = documentSnapshot.data();
    fname = data['fname'] ?? '';
    sname = data['sname'] ?? '';
    email = data['email'] ?? '';
    phoneNumber = data['phoneNumber'] ?? '';
    badgeno = data['badgeno'] ?? '';
    imageURL = data['imageURL'] ?? '';
  } else {
    print('Document does not exist!');
  }
}