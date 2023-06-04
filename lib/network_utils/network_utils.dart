import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirestoreAndStorage {
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  storeMediaInFirebaseStorage(context, imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = storage.ref().child('images/$fileName');
      UploadTask uploadTask = reference.putFile(imageFile);
      TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() {});
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

      String imageUrl = downloadUrl;

      firestore.collection('media').doc().set({
        'url': imageUrl,
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Media Uploaded')));
    } catch (e) {
      print(e.toString());
    }
  }
}
