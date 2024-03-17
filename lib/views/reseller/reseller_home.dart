import 'package:agromate/views/Reseller/Reseller_auth/Reseller_login.dart';
import 'package:agromate/views/reseller/reseller_add_reselldetails.dart';
import 'package:agromate/views/reseller/reseller_dashboard.dart';
import 'package:agromate/views/reseller/reseller_reselldetails_history.dart';
import 'package:agromate/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:agromate/configs/custom_colors.dart';

class ResellerHomeScreen extends StatefulWidget {
  final int ResellerId;
  const ResellerHomeScreen({super.key, 
  required this.ResellerId
  });

  @override
  State<ResellerHomeScreen> createState() => _ResellerHomeScreenState();
}

class _ResellerHomeScreenState extends State<ResellerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Reseller HOME',
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
                          builder: (context) =>  ResellerDashBoard(ResellerId: widget.ResellerId,),
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
                          builder: (context) => ResellerHistory(ResellerId: widget.ResellerId,),
                        ),
                      );
                    },
                    child: const Text(
                      'My Resell History',
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
                          builder: (context) =>  ResellerAddProduction(ResellerId: widget.ResellerId,),
                        ),
                      );
                    },
                    child: const Text(
                      'Add My Resell Details',
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
                builder: (context) => const ResellerLoginScreen(),
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
      backgroundColor: CustomColors.brownColor,
      foregroundColor: Colors.white,
      onPressed: onPressed,
      child: icon,
    );
  }
}
