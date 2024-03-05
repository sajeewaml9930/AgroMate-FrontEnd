import 'package:agromate/views/agriofficer/agri_officer_auth/agri_office_loging.dart';
import 'package:agromate/views/farmer/farmer_auth/farmer_login.dart';
import 'package:agromate/views/reseller/reseller_auth/reseller_login.dart';
import 'package:agromate/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:agromate/configs/custom_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: CustomColors.greenColor,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          color: CustomColors.hazelColor,
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonWidget(
                    width: 300,
                    height: 65,
                    borderRadius: 10,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OfficerLoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Officer',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ButtonWidget(
                    width: 300,
                    height: 65,
                    borderRadius: 10,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FarmerLoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Farmer',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ButtonWidget(
                    width: 300,
                    height: 65,
                    borderRadius: 10,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const resellerLoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Resaller',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Exit'),
              content: const Text('Are you sure you want to exit the app?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      }
    );
  }
}
