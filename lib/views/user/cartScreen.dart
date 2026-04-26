import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:mini_order/views/user/barScreen.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

Stream? meal_Stre_am;

//here i create table in firebase called foodName:
class _CartScreenState extends State<CartScreen> {
  Stream<QuerySnapshot> getFoodItem(String foodName) {
    return FirebaseFirestore.instance.collection(foodName).snapshots();
  }

  ontheload() async {
    meal_Stre_am = await getFoodItem("Cart");
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  Widget ourItem() {
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
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  ds["Image"],
                                  height: 80,
                                  width: 80,
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
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      "Quantity:${((ds.data() as Map<String, dynamic>)['quantity'] ?? "0").toString()}",
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                  ),
                                  const SizedBox(height: 5.0),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.money,
                                        size: 23,
                                        color: Color.fromARGB(168, 3, 56, 27),
                                      ),
                                      SizedBox(width: 3),
                                      Text(
                                        "\$" + ds["total"],
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
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
            : const Center(child: Text("No items"));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Expanded(child: ourItem())],
        ),
      ),
      backgroundColor: Colors.grey,
      appBar: AppBar(
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Get.offAll(() => BarPage());
              },
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),
        title: const Text(
          " Your Cart",
          style: TextStyle(
            color: Color.fromARGB(168, 3, 56, 27),
            fontSize: 26.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
