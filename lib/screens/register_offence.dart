import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/lists.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project/reusable_widgets/reusable_widgets.dart';
import '../functions/send_email.dart';
import '../reusable_widgets/app_bar.dart';
import '../reusable_widgets/listsitems.dart';
import '../reusable_widgets/side_navbar.dart';


class RegOffence extends StatefulWidget {
  const RegOffence({Key? key}) : super(key: key);

  @override
  State<RegOffence> createState() => _RegOffenceState();
}

class _RegOffenceState extends State<RegOffence> {
  final TextEditingController _idTextController = TextEditingController();
  final TextEditingController _modelTextController = TextEditingController();
  final TextEditingController _numberPlateTextController = TextEditingController();

  String vehicle = '',
      offence = '',
      location = '',
      mitigationConsidered = '',
      decision = ''
  ;

  CollectionReference _reference=FirebaseFirestore.instance.collection('offence');
  String imageUrl='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  SideNav(),
      appBar: const App(),
      body: SingleChildScrollView(
        child:
            Padding(padding: const EdgeInsets.fromLTRB(20,0,20,0),
              child:
              Column(
                  children: [
                    TextFormField(
                      controller: _idTextController,
                      decoration: const InputDecoration(
                        hintText: 'ID number',
                      ),
                    ),
                    Lists(items: vehicleType, text: 'Type of vehicle',
                        onItemSelected: (value) {
                          setState(() {
                            vehicle = value;
                          });
                        }
                    ),
                    TextFormField(controller: _modelTextController,
                      decoration: const InputDecoration(
                          hintText: 'Model'
                      ),
                    ),
                    TextFormField(controller: _numberPlateTextController,
                      decoration: const InputDecoration(
                          hintText: 'Number plate'
                      ),
                    ),
                    Lists(items: offences, text: 'Type of offence',
                        onItemSelected: (value) {
                          setState(() {
                            offence = value;
                          });}),
                    Lists(items: roads, text: 'Location',
                        onItemSelected: (value) {
                          setState(() {
                            location = value;
                          });}
                    ),
                    Lists(items: choice, text: 'Mitigation considered?',
                        onItemSelected: (value) {
                          setState(() {
                            mitigationConsidered = value;
                          });}),
                    Lists(items: decisions, text: 'Decision',
                        onItemSelected: (value) {
                          setState(() {
                            decision = value;
                          });}
                    ),
                    IconButton(onPressed: () async {
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


                      } catch(error) {}
                    },
                        icon: const Icon(Icons.camera_alt)),
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
                          mitigationConsidered.isEmpty ||
                          decision.isEmpty
                      ) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill in all the required fields.'))
                        );
                      }
                      //Create a map of data
                      Map<String, String> dataToSend = {
                        'idNumber': idNumber,
                        'typeOfVehicle': vehicle,
                        'model': model,
                        'number plate': numberPlate,
                        'offence': offence,
                        'location': location,
                        'mitigationConsidered': mitigationConsidered,
                        'decision': decision,
                        'imageURL' : imageUrl,
                      };

                      //add new document
                      _reference.add(dataToSend);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Data has been saved.'),
                        ),
                      );

                      sendEmail('olgangoni@students.uonbi.ac.ke');
                    })

                  ]
              )
            )

      )
    );
  }
}
