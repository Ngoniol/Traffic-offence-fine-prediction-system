import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CaptureEvidence extends StatefulWidget {
  final Function(String?) onCaptureEvidence;
  const CaptureEvidence({Key? key, required this.onCaptureEvidence}) : super(key: key);

  @override
  State<CaptureEvidence> createState() => _CaptureEvidenceState();
}

class _CaptureEvidenceState extends State<CaptureEvidence> {
  @override
  String imageUrl='';
  Image? capturedImage;
  Future<void> captureImage() async {
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
      // Pass the imageUrl to the callback function
      widget.onCaptureEvidence(imageUrl);
    } catch(error) {}
  }
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
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
            label: const Text('Capture Evidence'),
            onPressed: captureImage,
            icon: const Icon(Icons.camera_alt)),
        if (capturedImage != null)
          SizedBox(
            width: 50,
            height: 50,
            child:capturedImage,
          ),
      ],
    );
  }
}
