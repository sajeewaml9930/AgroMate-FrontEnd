import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/configs/url_location.dart';
import 'package:agromate/models/farmer_model.dart';
import 'package:agromate/models/officer_model.dart';
import 'package:agromate/views/agriofficer/agri_officer_auth/agri_office_loging.dart';
import 'package:agromate/views/farmer/farmer_home.dart';
import 'package:agromate/views/home.dart';
import 'package:agromate/views/widgets/alert_box_widget.dart';
import 'package:agromate/views/widgets/button_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FarmerRegistration extends StatefulWidget {
  const FarmerRegistration({super.key});

  @override
  _FarmerRegistrationState createState() => _FarmerRegistrationState();
}

class _FarmerRegistrationState extends State<FarmerRegistration> {
  bool isClicked = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertBoxWidget(
        title: 'SERVER',
        content: Text(message),
        buttonTitle: 'Okay',
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

Future<void> _registerFarmer() async {
    final url = Uri.parse('http://127.0.0.1:5000/register_farmer');
    
    // Replace these fields with the actual data you want to send
    final Map<String, String> data = {
      'name': 'John Doe',
      'area': 'Farmville',
      'ph_number': '1234567890',
      'status': 'Active',
      'password': 'password123',
    };

    try {
      final response = await http.post(
        url,
        body: data,
      );

      if (response.statusCode == 200) {
        // Registration successful
        print('Registered successfully');
      } else if (response.statusCode == 409) {
        // Name already exists
        print('Name already exists');
      } else {
        // Handle other status codes or errors
        print('Failed to register');
      }
    } catch (error) {
      // Handle network errors
      print('Network error: $error');
    }
  }
  @override
  void dispose() {
    //_fetchData();
    //dateinput.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //_fetchData();
    //final userData = OfficerDTO(name: 'Dinil',password: "12312" ,area: '106', phNumber: '121313');
    //postOfficerData(userData);
    super.initState();
  }

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _areaController = TextEditingController();
  final _phnumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Farmer Registration',
            style: TextStyle(
              color: Colors.white, // Choose your desired color
            ),
          ),
          centerTitle: true,
          backgroundColor: CustomColors.greenColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            ),
          ),
        ),
        body: Container(
          color: CustomColors.hazelColor,
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.brownColor,
                    ),
                  ),
                  Text(
                    'Enter your login credentials below!',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black.withOpacity(0.75),
                        ),
                  ),
                  Container(height: 30.0),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // Container(height: 16.0),
                  // TextField(
                  //   controller: _areaController,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Field Area Size',
                  //     border: OutlineInputBorder(),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.black),
                  //     ),
                  //     labelStyle: TextStyle(
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  // ),
                  Container(height: 16.0),
                  TextField(
                    controller: _phnumberController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(height: 50.0),
                  ButtonWidget(
                    width: double.infinity,
                    height: 45,
                    borderRadius: 10,
                    onPressed: () {
                      _registerFarmer();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => FarmerHomeScreen(
                      //             farmerId: 1,
                      //           )),
                      // );
                    },
                    child: const Text(
                      'Add Me',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
