import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/configs/url_location.dart';
import 'package:agromate/views/reseller/reseller_auth/reseller_login.dart';
import 'package:agromate/views/widgets/alert_box_widget.dart';
import 'package:agromate/views/widgets/button_widget.dart';
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

  Future<void> _registerReseller(
    TextEditingController nameController,
    TextEditingController phNumberController,
    TextEditingController passwordController,
    TextEditingController economic_centreController,
  ) async {
    final String name = nameController.text;
    final String phNumber = phNumberController.text;
    final String password = passwordController.text;
    final String economic_centre = economic_centreController.text;

    // Ensure all fields are filled
    if (name.isEmpty || phNumber.isEmpty || password.isEmpty) {
      _showErrorDialog("Please fill in all fields.");
      return;
    }

    final url = Uri.parse(UrlLocation.rr);

    // Convert data to JSON format
    final Map<String, String> data = {
      'name': name,
      'ph_number': phNumber,
      'password': password,
      'economic_centre': economic_centre,
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
                  builder: (context) => const ResellerLoginScreen()),
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
    //final userData = ResellerDTO(name: 'Dinil',password: "12312" ,area: '106', phNumber: '121313');
    //postResellerData(userData);
    super.initState();
  }

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phnumberController = TextEditingController();
  final _economic_centreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Reseller Registration',
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
                builder: (context) => const ResellerLoginScreen(),
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
                  Container(height: 16.0),
                  TextField(
                    controller: _economic_centreController,
                    decoration: const InputDecoration(
                      labelText: 'Economic Centre',
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
                      _registerReseller(_usernameController,
                          _phnumberController, _passwordController, _economic_centreController);
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
