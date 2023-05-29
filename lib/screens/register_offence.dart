import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/lists.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  DateTime? selectedDateTime;
  final TextEditingController _idTextController = TextEditingController();
  final TextEditingController _modelTextController = TextEditingController();
  final TextEditingController _numberPlateTextController = TextEditingController();
  String imageUrl='';
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
                          SelectDate(onDateTimeSelected: onDateTimeSelected,),
                        ],
                      ),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.black26;
                                }
                                return const Color(0xFF5d7fbe);
                              }),
                            ),
                            label: const Text('Capture Evidence'),onPressed: () async {
                          ImagePicker imagePicker = ImagePicker();
                          XFile? file= await imagePicker.pickImage(source: ImageSource.camera);
                          print('${file?.path}');

                          if(file==null) return;

                          String uniqueFileName=DateTime.now().millisecond.toString();

                          //reference to storage root
                          Reference referenceRoot=FirebaseStorage.instance.ref();
                          Reference referenceDirImages=referenceRoot.child('evidence');

                          //reference for the image being stored
                          Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

                          //Handle errors/success
                          try{
                            //store file
                            await referenceImageToUpload.putFile(File(file!.path));

                            //success:get download URL
                            imageUrl = await referenceImageToUpload.getDownloadURL();
                            setState(() {
                              // Set the captured image
                              capturedImage = Image.file(File(file!.path));
                            });


                          } catch(error) {}
                        },
                            icon: const Icon(Icons.camera_alt)),
                        if (capturedImage != null)
                          SizedBox(
                            width: 50,
                            height: 50,
                            child:capturedImage,
                          ),
                      ],
                    ),

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
                          'imageURL' : imageUrl,
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
                          'imageURL' : imageUrl,
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