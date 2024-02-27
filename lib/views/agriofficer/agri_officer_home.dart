import 'package:agromate/views/agriofficer/agri_officer_auth/agri_office_loging.dart';
import 'package:agromate/views/agriofficer/farmer_details.dart';
import 'package:agromate/views/agriofficer/forecasted_prices_production.dart';
import 'package:agromate/views/home.dart';
import 'package:agromate/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:agromate/configs/custom_colors.dart';

class AgriOfficerHomeScreen extends StatefulWidget {
  const AgriOfficerHomeScreen({super.key});
  @override
  State<AgriOfficerHomeScreen> createState() => _AgriOfficerHomeScreenState();
}

class _AgriOfficerHomeScreenState extends State<AgriOfficerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'OFFICR HOME',
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
                      'Farmers Details',
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
                          builder: (context) => FarmerDetails(),
                        ),
                      );
                    },
                    child: const Text(
                      'Resellers Details',
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
                          builder: (context) =>
                              const forecasted_prices_n_production(),
                        ),
                      );
                    },
                    child: const Text(
                      'Forcasted price productoin',
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
        floatingActionButton: _floatingActionButton(
          icon: const Icon(
            Icons.logout,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
        ),
      ),
    );
  }

  FloatingActionButton _floatingActionButton(
      {required Icon icon, required VoidCallback? onPressed}) {
    return FloatingActionButton(
      isExtended: true,
      backgroundColor: CustomColors.greenColor,
      foregroundColor: Colors.white,
      onPressed: onPressed,
      child: icon,
    );
  }
}
