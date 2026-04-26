import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_order/services/databaseService.dart';
import 'package:mini_order/services/local_storage_service.dart.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Addproducts extends StatefulWidget {
  const Addproducts({super.key});
  @override
  State<Addproducts> createState() => _AddproductsState();
}

class _AddproductsState extends State<Addproducts> {
  TextEditingController nameofFood = TextEditingController();
  TextEditingController priceofFood = TextEditingController();
  TextEditingController describiontofFood = TextEditingController();
  TextEditingController quantityofFood = TextEditingController();

  File? pickMeal;
  final ImagePicker takePicture = ImagePicker();

  //#2
  UploadFood() async {
    // التحقق من الحقول (Validation)
    if (pickMeal != null &&
        nameofFood.text.trim().isNotEmpty &&
        priceofFood.text.trim().isNotEmpty) {
      try {
        // إظهار مؤشر التحميل (Show Loading)
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(color: Colors.amber),
          ),
        );
        // رفع الصورة
        String? downloadUrl = await InDatabaseSharedFirebase()
            .uploadImageToFirebase(pickMeal!);
        if (!mounted) return;

        if (downloadUrl == null) {
          Navigator.pop(context);
          return;
        }
        Map<String, dynamic> categoryImage = {
          "Image": downloadUrl,
          "Name": nameofFood.text,
          "description_meal": describiontofFood.text,
          "total_Price": priceofFood.text,
          "quantity": quantityofFood.text,
        };
        await DatabaseServer().addToDatabase(categoryImage, "Meals");
        if (mounted) {
          Navigator.pop(context); // إغلاق مؤشر التحميل
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Your Product now in the app",
              style: TextStyle(fontSize: 20.0, color: Colors.amber),
            ),
          ),
        );
      } catch (e) {
        Navigator.pop(context); // إغلاق التحميل عند الخطأ
        print("Error during upload: $e");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields and select an image"),
        ),
      );
    }
  }

  // دالة اختيار الصورة
  Future<File?> pickImageFromGallery() async {
    final mealPicture = await takePicture.pickImage(
      source: ImageSource.gallery,
    );

    if (mealPicture != null) {
      setState(() {
        pickMeal = File(mealPicture.path);
      });
    }
    return null;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Products"),
        backgroundColor: Color.fromARGB(168, 3, 56, 27),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pickMeal == null
                  ? GestureDetector(
                      onTap: pickImageFromGallery,
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
                  : Center(
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.amber, width: 1.5),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.file(pickMeal!, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 10.0),
              const Text(
                "Product Name",
                style: TextStyle(
                  color: Color.fromARGB(168, 3, 56, 27),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),

                child: TextField(
                  controller: nameofFood,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Product Name",
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                "price:",
                style: TextStyle(
                  color: Color.fromARGB(168, 3, 56, 27),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: priceofFood,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "0.00 SR",
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                "Quantity:",
                style: TextStyle(
                  color: Color.fromARGB(168, 3, 56, 27),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: quantityofFood,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "1 or more",
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                "Description:",
                style: TextStyle(
                  color: Color.fromARGB(168, 3, 56, 27),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  maxLines: 4,
                  controller: describiontofFood,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: UploadFood,
                child: Center(
                  child: Material(
                    elevation: 10.0,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 7.0),
                      width: 150,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(168, 3, 56, 27),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Text(
                          "Add Product",
                          style: TextStyle(color: Colors.amber, fontSize: 25.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
