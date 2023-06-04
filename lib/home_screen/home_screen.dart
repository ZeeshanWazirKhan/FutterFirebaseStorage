import 'dart:io';

import 'package:firebase_storage_app/network_utils/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ImagePicker imagePicker = ImagePicker();
  File? imageFile;

  getImageFromGallery() async {
    var imageSource = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(imageSource!.path);
      print(imageFile.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: imageFile == null
                    ? Icon(
                        Icons.person,
                        size: 61,
                        color: Colors.grey,
                      )
                    : Image.file(
                        imageFile!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      )),
            MaterialButton(
              onPressed: getImageFromGallery,
              color: Colors.purple,
              textColor: Colors.white,
              child: Text('Pick Image From Gallery'),
            ),
            MaterialButton(
              onPressed: imageFile == null
                  ? null
                  : () {
                      FirestoreAndStorage()
                          .storeMediaInFirebaseStorage(context, imageFile);
                    },
              color: Colors.purple,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.grey,
              textColor: Colors.white,
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
