import 'package:agromate/screens/agriofficer/agri_officer_auth/agri_office_loging.dart';
import 'package:agromate/screens/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:agromate/configs/custom_colors.dart';

class FarmerHomeScreen extends StatefulWidget {
  const FarmerHomeScreen({super.key});

  @override
  State<FarmerHomeScreen> createState() => _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends State<FarmerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    // int userLevel =
    //     Provider.of<AuthModel>(context, listen: false).user?.userLevel ?? 0;

    return SafeArea(
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
                  // Provider.of<LogsModel>(context, listen: false).qrCode = '';
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const FarmerLoging(),
                  //   ),
                  // );
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
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const FarmerLoging(),
                  //   ),
                  // );
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
        // floatingActionButton: _floatingActionButton(
        //   icon: const Icon(
        //     Icons.logout,
        //   ),
        //   onPressed: () {},
        // ),
      ),
    );
  }

  // FloatingActionButton _floatingActionButton(
  //     {required Icon icon, required VoidCallback? onPressed}) {
  //   return FloatingActionButton(
  //     isExtended: true,
  //     backgroundColor: CustomColors.brownColor,
  //     foregroundColor: Colors.white,
  //     onPressed: onPressed,
  //     child: icon,
  //   );
  // }
}
