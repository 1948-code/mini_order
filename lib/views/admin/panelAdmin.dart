import 'package:flutter/material.dart';
import 'package:mini_order/views/admin/addProducts.dart';
import 'package:mini_order/views/admin/list_edit_delete.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

class PanelAdmin extends StatefulWidget {
  const PanelAdmin({super.key});
  State<PanelAdmin> createState() => _PanelAdmin();
}

class _PanelAdmin extends State<PanelAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 30),
        child: Column(
          children: [
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => Addproducts())),
                );
              },
              child: Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(20),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(168, 3, 56, 27),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.food_bank_outlined,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Text(
                          "Add your products",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => ListAdmin())),
                );
              },
              child: Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(20),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(168, 3, 56, 27),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.list_sharp,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Text(
                          "List of products",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey,
      appBar: AppBar(
        leading: Column(crossAxisAlignment: CrossAxisAlignment.start),
        centerTitle: true,
        title: const Text(
          " Admin Panel",
          style: TextStyle(
            color: Color.fromARGB(168, 3, 56, 27),
            fontSize: 40.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
