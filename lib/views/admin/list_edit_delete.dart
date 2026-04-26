import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_order/services/databaseService.dart';
import 'package:mini_order/services/local_storage_service.dart.dart';

class ListAdmin extends StatefulWidget {
  ListAdmin({super.key});

  State<ListAdmin> createState() => _ListAdmin();
}

class _ListAdmin extends State<ListAdmin> {
  Stream? meal_Stre_am;

  TextEditingController nameController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  TextEditingController imageUrl = new TextEditingController();
  File? pickMeal;
  // دالة اختيار الصورة
  Future<File?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final mealPicutre = await picker.pickImage(source: ImageSource.gallery);
    if (mealPicutre != null) {
      return File(mealPicutre.path);
    }
    return null;
  }

  void openNoteBox({String? docId}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Product Name",
                ),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "description",
                ),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "0.00 SR",
                ),
              ),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "1 or more",
                ),
              ),
              pickMeal == null
                  ? GestureDetector(
                      onTap: () async {
                        File? image = await pickImageFromGallery();

                        if (image != null) {
                          setState(() {
                            pickMeal = image;
                          });
                        }
                      },
                      child: Center(
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            height: 160,
                            width: 160,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.amber,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Icon(
                              Icons.image_outlined,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        File? image = await pickImageFromGallery();

                        if (image != null) {
                          setState(() {
                            pickMeal = image;
                          });
                        }
                      },
                      child: Center(
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            height: 160,
                            width: 160,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.amber,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.file(pickMeal!, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (docId != null) {
                String? uploadedImageUrl;

                // رفع الصورة فقط إذا تم اختيار صورة
                if (pickMeal != null) {
                  uploadedImageUrl = await InDatabaseSharedFirebase()
                      .uploadImageToFirebase(pickMeal!);
                }

                // تجهيز البيانات
                Map<String, dynamic> data = {
                  "Name": nameController.text,
                  "description_meal": descController.text,
                  "total_Price": priceController.text,
                  "quantity": quantityController.text,
                };

                // إضافة الصورة فقط إذا تم تحديثها
                if (uploadedImageUrl != null) {
                  data["Image"] = uploadedImageUrl;
                }

                await DatabaseServer.updateMeals(docId, data);

                // تنظيف الحقول
                nameController.clear();
                descController.clear();
                priceController.clear();
                quantityController.clear();
                imageUrl.clear();
                //close the edit box:
                Navigator.pop(context);
              }
            },
            child: const Text("Edit"),
          ),
        ],
      ),
    );
  }

  //here i create table in firebase called foodName:
  Future<Stream<QuerySnapshot>> getFoodItem(String foodName) async {
    return FirebaseFirestore.instance.collection(foodName).snapshots();
  }

  ontheload() async {
    meal_Stre_am = await getFoodItem("Meals");
    setState(() {});
  }

  void initState() {
    super.initState();
    ontheload();
  }

  Widget adminItem() {
    return StreamBuilder(
      stream: meal_Stre_am,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, Index) {
                  DocumentSnapshot ds = snapshot.data.docs[Index];
                  String imageUrl = (ds["Image"] ?? '').trim();

                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(right: 8.0, bottom: 4.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: imageUrl.isNotEmpty
                                    ? Image.network(
                                        imageUrl,
                                        height: 90,
                                        width: 90,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Image.asset(
                                                'assets/placeholder.jpg',
                                                height: 90,
                                                width: 90,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                      )
                                    : Image.asset(
                                        'assets/placeholder.jpg',
                                        height: 90,
                                        width: 90,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              SizedBox(width: 8.0),
                              Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      ds["Name"],
                                      style: TextStyle(fontSize: 18.0),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      ds["description_meal"],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      (ds.data()
                                                  as Map<
                                                    String,
                                                    dynamic
                                                  >)['quantity']
                                              ?.toString() ??
                                          "0",
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.8,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.money,
                                          size: 23,
                                          color: Color.fromARGB(168, 3, 56, 27),
                                        ),
                                        SizedBox(width: 3),

                                        Text(
                                          "\$${ds["total_Price"]}",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 14),
                                        ),

                                        Spacer(),

                                        IconButton(
                                          onPressed: () =>
                                              openNoteBox(docId: ds.id),
                                          icon: Icon(
                                            Icons.edit,
                                            color: Color.fromARGB(
                                              168,
                                              3,
                                              56,
                                              27,
                                            ),
                                          ),
                                        ),

                                        IconButton(
                                          onPressed: () async {
                                            await DatabaseServer().deleteMeals(
                                              "Meals",
                                              ds.id,
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Color.fromARGB(
                                              168,
                                              3,
                                              56,
                                              27,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text("All my products"),
        backgroundColor: Color.fromARGB(168, 3, 56, 27),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 30),
        child: adminItem(),
      ),
    );
  }
}
