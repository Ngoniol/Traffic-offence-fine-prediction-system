import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/capture_evidence.dart';
import 'package:project/functions/lists.dart';
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
  String? imageUrl;
  Image? capturedImage;
  String vehicle = '',
      offence = '',
      location = '',
      decision = '',
      court = '',
      message = '',
      offence_date='',
      court_date=''
  ;
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
                    Lists(items: offences, text: 'Type of offence',
                        onItemSelected: (value) {
                          setState(() {
                            offence = value;
                          });}),
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
                    CaptureEvidence(onCaptureEvidence: onCaptureEvidence),
                    functionButton(context, 'Submit', 0xFF1D438C, (){
                      String idNumber = _idTextController.text,
                          model = _modelTextController.text,
                          numberPlate = _numberPlateTextController.text;

                      if(idNumber.isEmpty ||
                          vehicle.isEmpty ||
                          model.isEmpty ||
                          numberPlate.isEmpty ||
                          offence.isEmpty ||
                          location.isEmpty ||
                          decision.isEmpty
                      ) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill in all the required fields.'))
                        );
                      }
                      offence_date=DateTime.now().toString();
                      court_date=selectedDateTime.toString();

                      if (decision == 'Notice to attend Court'){
                        //Create a map of data
                        Map<String, String> dataToSend = {
                          'idNumber': idNumber,
                          'typeOfVehicle': vehicle,
                          'model': model,
                          'number plate': numberPlate,
                          'offence': offence,
                          'location': location,
                          'offence_date':offence_date,
                          'decision': decision,
                          'court': court,
                          'court_date':court_date,
                          if (imageUrl != null) 'imageURL': imageUrl!,
                        };
                        //add new document
                        _reference.add(dataToSend);
                        message = 'You are hereby required to attend $court on $court_date. You were charged with $offence which is contrary to Section of the Kenya Traffic Act which was committed at $location on $offence_date';
                      }
                      else if(decision == 'Fine on the spot'){
                        //Create a map of data
                        Map<String, String> dataToSend = {
                          'idNumber': idNumber,
                          'typeOfVehicle': vehicle,
                          'model': model,
                          'number plate': numberPlate,
                          'offence': offence,
                          'location': location,
                          'offence_date':DateTime.now().toString(),
                          'decision': decision,
                          if (imageUrl != null) 'imageURL': imageUrl!,
                        };
                        //add new document
                        _reference.add(dataToSend);
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Data has been saved.'),
                        ),
                      );
                      sendEmail('mercymutua014@gmail.com', message);
                      sendNotification();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const RegOffence()));
                    })
                  ]
              )
            )
      )
    );
  }
}