import 'package:agromate/configs/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // _navigateToHomeScreen();
  }

//   Future<void> _navigateToHomeScreen() async {
//     await Future.delayed(const Duration(seconds: 2)).then(
//       (value) => Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const LoginScreen(),
//         ),
//       ),
//     );
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to CropCoach',
              style: TextStyle(fontSize: 20.0),
            ),
            Image.asset(
              'assets/images/splashscreen.jpeg',
              width: Constants.screenSize(context).width*0.75,
            ),
          ],
        ),
      ),
    );
  }
}
