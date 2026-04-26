import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mini_order/views/user/cartScreen.dart';
import 'package:mini_order/views/user/homeFood.dart';

class BarPage extends StatefulWidget {
  const BarPage({super.key});

  @override
  State<BarPage> createState() => _BarPage();
}

class _BarPage extends State<BarPage> {
  int currentTable = 0;
  late List<Widget> screens;
  late Widget currentScreen;
  late Homefood homefood;
  late CartScreen cart;

  @override
  void initState() {
    homefood = Homefood();
    cart = CartScreen();
    screens = [homefood, cart];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.black87,
        animationDuration: const Duration(microseconds: 600),
        onTap: (int index) {
          setState(() {
            currentTable = index;
          });
        },
        height: 60.0,
        items: const [
          Icon(Icons.home, color: Colors.white, size: 30.0),
          Icon(Icons.shopping_bag, color: Colors.white, size: 30.0),
        ],
      ),
      body: screens[currentTable],
    );
  }
}
