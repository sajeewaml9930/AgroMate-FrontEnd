import 'package:agromate/views/farmer/farmer_add_production.dart';
import 'package:agromate/views/farmer/farmer_auth/farmer_login.dart';
import 'package:agromate/views/farmer/farmer_dashboard.dart';
import 'package:agromate/views/farmer/farmer_production_history.dart';
import 'package:agromate/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:agromate/configs/custom_colors.dart';

class FarmerHomeScreen extends StatefulWidget {
  final int farmerId;
  const FarmerHomeScreen({super.key, required this.farmerId});

  @override
  State<FarmerHomeScreen> createState() => _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends State<FarmerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
                  child: const Text('Sign Out',
                    style: TextStyle(color: Colors.red),),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(color: Color.fromARGB(255, 0, 18, 77)),
                  ),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'FARMER HOME',
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
                          builder: (context) => FarmerDashBoard(
                            farmerId: widget.farmerId,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'My Dashboard',
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
                          builder: (context) => FarmerHistory(
                            farmerId: widget.farmerId,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'My Production Details',
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
                          builder: (context) => AddProduction(
                            farmerId: widget.farmerId,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Add My Production',
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
                builder: (context) => const FarmerLoginScreen(),
              ),
            );
          },
        ),
      ),
    );
  }

  FloatingActionButton _floatingActionButton({required Icon icon, required VoidCallback? onPressed}) {
    return FloatingActionButton(
      isExtended: true,
      backgroundColor: CustomColors.brownColor,
      foregroundColor: Colors.white,
      onPressed: onPressed,
      child: icon,
    );
  }
}
