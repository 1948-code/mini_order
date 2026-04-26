import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mini_order/services/databaseService.dart';
import 'package:mini_order/services/local_storage_service.dart.dart';

class ShowMeal extends StatefulWidget {
  String picture, totalpay, foodName, description, quantity;
  ShowMeal({
    required this.foodName,
    required this.description,
    required this.picture,
    required this.totalpay,
    required this.quantity,
  });

  @override
  State<ShowMeal> createState() => _ShowMealState();
}

class _ShowMealState extends State<ShowMeal> {
  //create function for counter (add, remove) meals :
  int a = 1;
  int all = 0;
  String? uniqe;
  uploadToCart() async {
    if (uniqe != null) {
      Map<String, dynamic> reserveTheMeal = {
        "Name": widget.foodName,
        "quantity": a,
        "total": all.toString(),
        "Image": widget.picture,
      };

      await DatabaseServer().addToCart(reserveTheMeal, uniqe!);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        (SnackBar(
          backgroundColor: Color.fromARGB(168, 3, 56, 27),
          content: Text(
            "added to cart successfully",
            style: TextStyle(fontSize: 20.0),
          ),
        )),
      );
    }
  }

  Future<void> getthesharedpref() async {
    uniqe = await InDatabaseSharedFirebase().getCustomerUniqe('customerUniqe');
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  int price = 0;
  void initState() {
    super.initState();
    ontheload();
    price = int.tryParse(widget.totalpay) ?? 0;
    all = price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[10],
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        title: const Text(
          " Your order ",
          style: TextStyle(
            color: Color.fromARGB(168, 3, 56, 27),
            fontSize: 26.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: uniqe == null
          ? CircularProgressIndicator()
          : Container(
              margin: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.picture,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      // إضافة errorBuilder للتعامل مع روابط Unsplash التالفة
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 200),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.foodName,
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                      //make empty space between the name of the meal and the counter :
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (a > 1) {
                              a--;
                              all -= price;
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(Icons.remove, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(a.toString(), style: TextStyle(fontSize: 25.0)),
                      const SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            a++;
                            all += price;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    widget.description,
                    style: TextStyle(fontSize: 16.0),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 100.0),
                  Text(
                    "Quantity: ${widget.quantity}",
                    style: const TextStyle(fontSize: 20),
                  ),

                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total : $all", style: TextStyle(fontSize: 20.0)),
                        const SizedBox(height: 30.0),
                        GestureDetector(
                          onTap: uploadToCart,
                          child: Center(
                            child: Material(
                              elevation: 10.0,
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 7.0,
                                ),
                                width: 150,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(168, 3, 56, 27),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Add to Cart",
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: 25.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
