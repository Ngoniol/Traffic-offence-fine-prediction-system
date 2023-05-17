import 'dart:io';
import 'package:intl/intl.dart';
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
  DateTime? selectedDateTime;
  Image? capturedImage;
  String vehicle = '',
      offence = '',
      location = '',
      mitigationConsidered = '',
      decision = '',
      court = ''
  ;

  CollectionReference _reference=FirebaseFirestore.instance.collection('offence');
  String imageUrl='';
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 7)),
      selectableDayPredicate: (DateTime date) {
        // Exclude weekends (Saturday and Sunday)
        if (date.weekday == 6 || date.weekday == 7) {
          return false;
        }
        return true;
      },
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedDateTime != null
            ? TimeOfDay.fromDateTime(selectedDateTime!)
            : TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }
  String _formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(dateTime);
  }

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
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _idTextController,
                      decoration: const InputDecoration(
                        hintText: 'ID number',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFBDBDBD), width: 0.3),
                        ),
                      ),
                    ),
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
                    TextFormField(controller: _modelTextController,
                      decoration: const InputDecoration(
                          hintText: 'Model',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFBDBDBD), width: 0.3),
                        ),
                      ),
                    ),
                    TextFormField(controller: _numberPlateTextController,
                      decoration: const InputDecoration(
                          hintText: 'Number plate',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFBDBDBD), width: 0.3),
                        ),
                      ),
                    ),

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
                          Row(children: [
                            ElevatedButton.icon(onPressed: () => _selectDateTime(context),
                              icon: const Icon(Icons.calendar_month),
                              label: const Text('Court date'),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.black26;
                                  }
                                  return const Color(0xFF5d7fbe);
                                }),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            if (selectedDateTime != null)
                              Text('Court date: ${_formatDateTime(selectedDateTime!)}')
                          ]),
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
                            width: 100,
                            height: 100,
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

                      sendEmail('mercymutua014@gmail.com');
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
