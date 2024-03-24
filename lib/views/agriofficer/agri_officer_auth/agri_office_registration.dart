import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/configs/url_location.dart';
import 'package:agromate/views/agriofficer/agri_officer_auth/agri_office_loging.dart';
import 'package:agromate/views/widgets/alert_box_widget.dart';
import 'package:agromate/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OfficerRegistration extends StatefulWidget {
  const OfficerRegistration({super.key});

  @override
  _OfficerRegistrationState createState() => _OfficerRegistrationState();
}

class _OfficerRegistrationState extends State<OfficerRegistration> {
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

  Future<void> _registerOfficer(
    TextEditingController nameController,
    TextEditingController phNumberController,
    TextEditingController passwordController,
  ) async {
    final String name = nameController.text;
    final String phNumber = phNumberController.text;
    final String password = passwordController.text;

    // Ensure all fields are filled
    if (name.isEmpty || phNumber.isEmpty || password.isEmpty) {
      _showErrorDialog("Please fill in all fields.");
      return;
    }

    final url = Uri.parse(UrlLocation.ar);

    // Convert data to JSON format
    final Map<String, String> data = {
      'name': name,
      'ph_number': phNumber,
      'password': password,
    };

    try {
      final response = await http.post(
        url,
        body: data,
      );
      final responseData = json.decode(response.body);

      if (response.statusCode == 201) {
        showDialog(
          context: context,
          builder: (context) => AlertBoxWidget(
            title: 'Success...',
            content: Text.rich(
              TextSpan(
                text: responseData['message'],
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      height: 1.5,
                    ),
              ),
              textAlign: TextAlign.center,
            ),
            buttonTitle: 'Okay',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OfficerLoginScreen()),
            ),
          ),
        );
        print('Registered successfully');
      } else if (response.statusCode == 401) {
        showDialog(
          context: context,
          builder: (context) => AlertBoxWidget(
            title: 'Try Again',
            content: Text.rich(
              TextSpan(
                text: responseData['message'],
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      height: 1.5,
                    ),
              ),
              textAlign: TextAlign.center,
            ),
            buttonTitle: 'Okay',
            onPressed: () => Navigator.pop(context),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertBoxWidget(
            title: 'Try Again',
            content: Text.rich(
              TextSpan(
                text: responseData['message'],
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      height: 1.5,
                    ),
              ),
              textAlign: TextAlign.center,
            ),
            buttonTitle: 'Okay',
            onPressed: () => Navigator.pop(context),
          ),
        );
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertBoxWidget(
          title: 'Try Again',
          content: Text.rich(
            TextSpan(
              text: 'Server Error',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    height: 1.5,
                  ),
            ),
            textAlign: TextAlign.center,
          ),
          buttonTitle: 'Okay',
          onPressed: () => Navigator.pop(context),
        ),
      );
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
                builder: (context) => const OfficerLoginScreen(),
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
                    'Registration',
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
                      _registerOfficer(_usernameController, _phnumberController,
                          _passwordController);
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
