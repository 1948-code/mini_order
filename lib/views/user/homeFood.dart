import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mini_order/services/local_storage_service.dart.dart';
import 'package:mini_order/views/user/showMealScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homefood extends StatefulWidget {
  const Homefood({super.key});

  @override
  State<Homefood> createState() => _Homefood();
}

class _Homefood extends State<Homefood> {
  Stream<QuerySnapshot>? meal_Stre_am;

  Future<Stream<QuerySnapshot>> getMeal(String category) async {
    return FirebaseFirestore.instance.collection('Meals').snapshots();
  }

  Future<void> oftheload() async {
    meal_Stre_am = await getMeal("Meals");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    oftheload();
  }

  Widget product() {
    return StreamBuilder<QuerySnapshot>(
      stream: meal_Stre_am,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data!.docs.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];

            final quantity = ds['quantity'] ?? 0;
            String imageUrl = (ds['Image'] ?? '').trim();

            return GestureDetector(
              onTap: () async {
                await InDatabaseSharedFirebase().saveCustomerUniqe("");

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowMeal(
                      foodName: ds["Name"].toString(),
                      description: ds["description_meal"].toString(),
                      picture: imageUrl,
                      totalpay: ds["total_Price"].toString(),
                      quantity: quantity.toString(),
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20.0, bottom: 20.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    padding: const EdgeInsets.all(17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: imageUrl.isNotEmpty
                              ? Image.network(
                                  imageUrl,
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/placeholder.jpg',
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Image.asset(
                                  'assets/placeholder.jpg',
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          ds["Name"],
                          style: const TextStyle(fontSize: 20.0),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          ds["description_meal"],
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.money,
                              size: 15.0,
                              color: Color.fromARGB(168, 3, 56, 27),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              "\$${ds["total_Price"]}",
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(width: 60),
                            Text(
                              "Quantity:$quantity",
                              style: const TextStyle(fontSize: 14),
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(3.0),
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/dish.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
          child: Scaffold(
            backgroundColor: Colors.white.withOpacity(0.0),
            body: Column(
              children: [
                const SizedBox(height: 50.0),
                SizedBox(height: 350.0, child: product()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
