import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/capture_evidence.dart';
import 'package:project/functions/get_driver.dart';
import 'package:project/functions/get_offence_details.dart';
import 'package:project/functions/lists.dart';
import 'package:project/functions/mpesa_payment.dart';
import 'package:project/functions/select_date.dart';
import 'package:project/reusable_widgets/reusable_widgets.dart';
import '../functions/send_email.dart';
import '../reusable_widgets/app_bar.dart';
import '../reusable_widgets/listsitems.dart';
import '../reusable_widgets/side_navbar.dart';
import '../functions/notification.dart';

class RegOffence extends StatefulWidget {
  const RegOffence({Key? key}) : super(key: key);

  @override
  State<RegOffence> createState() => _RegOffenceState();
}

class _RegOffenceState extends State<RegOffence> {
  //Initializing variables
  final TextEditingController _idTextController = TextEditingController();
  final TextEditingController _modelTextController = TextEditingController();
  final TextEditingController _numberPlateTextController = TextEditingController();
  DateTime? selectedDateTime;
  String? imageUrl, offence, paymentMethod;
  Image? capturedImage;
  String idNumber = '',
      model = '',
      numberPlate = '',
      vehicle = '',
      location = '',
      decision = '',
      court = '',
      courtMessage = '',
      fineMessage = '',
      offence_date='',
      court_date=''
  ;
  bool validateNumberPlate(String plate) {
    // Regular expression for the Kenyan number plate format
    RegExp plateRegex = RegExp(r'^[A-Z]{3}\s\d{3}[A-Z]$');
    return plateRegex.hasMatch(plate);
  }

  final CollectionReference _reference=FirebaseFirestore.instance.collection('offence');

  void onDateTimeSelected(DateTime? dateTime){
    setState(() {
      selectedDateTime = dateTime;
    });
  }
  void onCaptureEvidence(String? url){
    setState(() {
      imageUrl = url;
    });

  }
  String _formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
    return formatter.format(dateTime);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:  const SideNav(),
        appBar: const App(),
        body: SingleChildScrollView(
            child:
            Padding(padding: const EdgeInsets.fromLTRB(20,20,20,0),
                child:
                Column(
                    children: [
                      inputTextField(_idTextController, 'ID number'),
                      const SizedBox(
                        height: 10,
                      ),
                      Lists(items: vehicleType, text: 'Type of vehicle',
                          onItemSelected: (value) {
                            setState(() {
                              vehicle = value;
                            });
                          }
                      ),
                      inputTextField(_modelTextController, 'Model'),
                      inputTextField(_numberPlateTextController, 'Number plate'),
                      const SizedBox(
                        height: 10,
                      ),
                      Lists(items: offenceTypes, text: 'Type of offence',
                          onItemSelected: (value) {
                            setState(() {
                              offence = value;
                            });}),
                      if(offence != null)
                        getOffenceDetails(selectedOffence: offence!),
                      Lists(items: roads, text: 'Location of offense',
                          onItemSelected: (value) {
                            setState(() {
                              location = value;
                            });}
                      ),
                      Lists(items: decisions, text: 'NTAC or Fine on the spot',
                          onItemSelected: (value) {
                            setState(() {
                              decision = value;
                            });}
                      ),
                      if (decision == 'Notice to attend Court')
                        Column(
                          children: [
                            Lists(items: courts, text: 'Court to attend',
                                onItemSelected: (value) {
                                  setState(() {
                                    court = value;
                                  });}
                            ),
                            SelectDate(onDateTimeSelected: onDateTimeSelected),
                          ],
                        ),
                      if (decision == 'Fine on the spot')
                        Column(
                          children: [
                            Lists(items: paymentMethods, text: 'Payment method',
                                onItemSelected: (value) {
                                  setState(() {
                                    paymentMethod = value;
                                  });
                                })
                          ],
                        ),
                      CaptureEvidence(onCaptureEvidence: onCaptureEvidence),
                      functionButton(context, 'Submit', 0xFF1D438C, () async {
                        idNumber = _idTextController.text;
                        model = _modelTextController.text;
                        numberPlate = _numberPlateTextController.text;
                        offence_date=(_formatDateTime(DateTime.now()));

                        if(idNumber.isEmpty ||
                            vehicle.isEmpty ||
                            model.isEmpty ||
                            numberPlate.isEmpty ||
                            offence!.isEmpty ||
                            location.isEmpty ||
                            decision.isEmpty || !validateNumberPlate(_numberPlateTextController.text)
                        ) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please fill in all the required fields correctly.'),backgroundColor: Colors.red,)
                          );
                        }
                        else {
                          await getDriver(idNumber);
                          courtMessage = 'You are hereby required to attend $court on $court_date. You were charged with $offence which is contrary to Section of the Kenya Traffic Act which was committed at $location on $offence_date';
                          fineMessage = 'You have been charged with $offence which is contrary to Section of the Kenya Traffic Act which was committed at $location on $offence_date';
                          if (decision == 'Notice to attend Court'){
                            court_date=(_formatDateTime(selectedDateTime!));
                            //Create a map of data
                            Map<String, String> dataToSend = {
                              'idNumber': idNumber,
                              'typeOfVehicle': vehicle,
                              'model': model,
                              'number plate': numberPlate,
                              'offence': offence!,
                              'location': location,
                              'offence_date':offence_date,
                              'decision': decision,
                              'court': court,
                              'court_date':court_date,
                              if (imageUrl != null) 'imageURL': imageUrl!,
                            };
                            //add new document
                            _reference.add(dataToSend);
                            sendNotification(court);
                            sendEmail(driverEmail, courtMessage);
                          }
                          else if(decision == 'Fine on the spot'){
                            //Create a map of data
                            Map<String, String> dataToSend = {
                              'idNumber': idNumber,
                              'typeOfVehicle': vehicle,
                              'model': model,
                              'number plate': numberPlate,
                              'offence': offence!,
                              'location': location,
                              'offence_date':DateTime.now().toString(),
                              'decision': decision,
                              if (imageUrl != null) 'imageURL': imageUrl!,
                            };
                            //add new document
                            _reference.add(dataToSend);
                            sendEmail(driverEmail, fineMessage);
                            await mpesaPayment(driverPhoneNumber);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Data has been saved.'),backgroundColor: Colors.lightGreen,
                            ),
                          );
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const RegOffence()));
                        }
                      })
                    ]
                )
            )
        )
    );
  }
}