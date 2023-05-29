import 'package:cloud_firestore/cloud_firestore.dart';

//initializing variables
String driverFirstName = '';
String driverSurname = '';
String driverEmail = '';
String driverPhoneNumber = '';
String driverIdNumber = '';

Future<void> getDriver(String idNumber) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('drivers')
      .where('idNumber', isEqualTo: idNumber)
      .limit(1)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    final documentSnapshot = querySnapshot.docs.first;
    final data = documentSnapshot.data();
    driverFirstName = data['fname'] ?? '';
    driverSurname = data['sname'] ?? '';
    driverEmail = data['email'] ?? '';
    driverPhoneNumber = data['phoneNumber'] ?? '';
    driverIdNumber = data['idNumber'] ?? '';
    print('$driverEmail exist!');
  } else {
    print('This document does not exist!');
  }
}