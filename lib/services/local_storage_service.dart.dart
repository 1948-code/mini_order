import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:firebase_storage/firebase_storage.dart';

class InDatabaseSharedFirebase {
  static String customer_id = "CUSTOMERID";
  //FUNCTION TO SAVE CUSTOMER ID AND HID ORDER:
  Future<bool> saveCustomerUniqe(String id) async {
    SharedPreferences sharCustomer = await SharedPreferences.getInstance();
    return sharCustomer.setString(customer_id, id);
  }

  //RETURN THE PREVIWS SAVED ID:
  Future<String?> getCustomerUniqe(String s) async {
    SharedPreferences sharCustomer2 = await SharedPreferences.getInstance();
    return sharCustomer2.getString(customer_id);
  }

  //# generate id for each product:
  // الاتصال بخدمة التخزين (Firebase Storage)
  Future<String?> uploadImageToFirebase(File imageFile) async {
    try {
      String appId = randomAlphaNumeric(5);
      Reference databaseImage = FirebaseStorage.instance
          .ref()
          .child("databaseImages")
          .child(appId);
      final UploadTask uploadImage = databaseImage.putFile(imageFile!);
      final snapshot = await uploadImage;
      var downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Upload Error: $e");
      return null;
    }
  }
}
