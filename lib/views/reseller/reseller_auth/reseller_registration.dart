import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/configs/url_location.dart';
import 'package:agromate/models/officer_model.dart';
import 'package:agromate/views/agriofficer/agri_officer_auth/agri_office_loging.dart';
import 'package:agromate/views/home.dart';
import 'package:agromate/views/widgets/alert_box_widget.dart';
import 'package:agromate/views/widgets/button_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResellerRegistration extends StatefulWidget {
  const ResellerRegistration({super.key});

  @override
  _ResellerRegistrationState createState() => _ResellerRegistrationState();
}

class _ResellerRegistrationState extends State<ResellerRegistration> {
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

  Future<void> postOfficerData(Officer userData) async {
    final url = Uri.parse('${UrlLocation.Url}/register_Officer'); // Replace with your API endpoint URL
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = jsonEncode(userData.toJson());

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print('Data posted successfully');
      } else {
        print('Failed to post data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error posting data: $e');
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
  // final _areaController = TextEditingController();
  final _phnumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Officer Registration',
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
                    onPressed: () async {
                      // Internet connection check
                      final connectivityResult =
                          await (Connectivity().checkConnectivity());

                      // Check if the network connectivi
                      if (connectivityResult == ConnectivityResult.none) {
                        _showErrorDialog('No Network Connection. Try Again!');
                      } else {
                        String username = _usernameController.text;
                        String password = _usernameController.text;
                        String ph_number = _usernameController.text;
                        final userData = Officer(
                          name: username,
                          password: password,
                          phNumber: ph_number,
                        );
                        postOfficerData(userData);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OfficerLoginScreen()),
                        );
                      }
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
