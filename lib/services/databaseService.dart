import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServer {
  //read data of Meals from database:
  Future<QuerySnapshot> getMealsInfo(String name) async {
    return await FirebaseFirestore.instance
        .collection("Meals")
        .where("Name", isEqualTo: name)
        .get();
  }

  //this Function move the item(meal) to the cart screen by User, where uses can view list of their orders.:
  Future addToCart(
    Map<String, dynamic> mapCustomer,
    String categoryName,
  ) async {
    return await FirebaseFirestore.instance.collection('Cart').add(mapCustomer);
  }

  //Add: Products to Fireebase Store by Admin:
  Future addToDatabase(
    Map<String, dynamic> mapCustomer,
    String categoryName,
  ) async {
    return await FirebaseFirestore.instance
        .collection(categoryName)
        .add(mapCustomer);
  }

  //Update :(Edit)
  static Future<void> updateMeals(
    String docId,
    Map<String, dynamic> data,
  ) async {
    return await FirebaseFirestore.instance
        .collection('Meals')
        .doc(docId)
        .update(data);
  }

  //Delete: products given a doc id:
  Future<void> deleteMeals(String collection, String docId) async {
    return await FirebaseFirestore.instance
        .collection(collection)
        .doc(docId)
        .delete();
  }
}
