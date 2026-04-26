import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_order/views/auth/screens/loginScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  // ignore: constant_identifier_names
  static const KMainHome = Color(0xFFFAEAD1);
  Null get thirdColor => null;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: KMainHome,
        body: Container(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: const AssetImage('assets/profile.png'),
                width: screenWidth,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 100),
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Welcome to Mini Order App',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Color.fromARGB(168, 3, 56, 27),
                        fontFamily: 'Poppins2',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              //put space between text and the buttons , 20 height:
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.to(const LoginScreen()),
                      style: OutlinedButton.styleFrom(
                        elevation: 4,
                        foregroundColor: (Colors.blueGrey),
                        backgroundColor: (Colors.white),
                        side: const BorderSide(color: Colors.black),
                        padding: const EdgeInsets.symmetric(vertical: 25.0),
                      ),
                      child: Text(
                        " Let's buy food".toUpperCase(),
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color.fromARGB(168, 3, 56, 27),
                          fontFamily: 'Poppins2',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.to(const LoginScreen()),
                      style: OutlinedButton.styleFrom(
                        elevation: 4,
                        foregroundColor: (Colors.blueGrey),
                        backgroundColor: (Colors.white),
                        side: const BorderSide(color: Colors.black),
                        padding: const EdgeInsets.symmetric(vertical: 25.0),
                      ),
                      child: Text(
                        "Add Your Product ".toUpperCase(),
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color.fromARGB(168, 3, 56, 27),
                          fontFamily: 'Poppins2',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
