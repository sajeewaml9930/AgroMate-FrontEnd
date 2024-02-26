import 'dart:convert';
import 'package:agromate/configs/url_location.dart';
import 'package:agromate/views/agriofficer/agri_officer_auth/agri_office_registration.dart';
import 'package:agromate/views/agriofficer/agri_officer_home.dart';
import 'package:agromate/views/home.dart';
import 'package:http/http.dart' as http;
import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/views/widgets/alert_box_widget.dart';
import 'package:agromate/views/widgets/button_widget.dart';
import 'package:agromate/views/widgets/label_widget.dart';
import 'package:agromate/views/widgets/text_field_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class resellerLoginScreen extends StatefulWidget {
  const resellerLoginScreen({super.key});

  @override
  State<resellerLoginScreen> createState() => _resellerLoginScreenState();
}

class _resellerLoginScreenState extends State<resellerLoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isClicked = false;

  Future<void> login() async {
    final url = Uri.parse('${UrlLocation.Url}/officer_login');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'name': _usernameController.text,
      'password': _passwordController.text,
    });

    final response = await http.post(url, headers: headers, body: body);
    final responseData = json.decode(response.body);

    if (response.statusCode == 201) {
      setState(() {
        final decoded = jsonDecode(response.body) as Map<String, dynamic>;
        final message = decoded['message'] as String;
        final farmerId = decoded['id'];

        print(farmerId);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AgriOfficerHomeScreen(),
            ));
      });
    } else {
      setState(() {
        showDialog(
          context: context,
          builder: (context) => AlertBoxWidget(
            title: 'Forgot Password?',
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
      });
    }
  }

  void _forgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertBoxWidget(
        title: 'Forgot Password?',
        content: Text.rich(
          TextSpan(
            text: 'Contact Admin\n',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  height: 1.5,
                ),
            children: [
              TextSpan(
                text: 'Tel: 0756770843',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      height: 1.5,
                    ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        buttonTitle: 'Okay',
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  void _signUpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertBoxWidget(
        title: 'Don\'t have an account?',
        content: Text.rich(
          TextSpan(
            text: 'Contact admin\n',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  height: 1.5,
                ),
            children: [
              TextSpan(
                text: 'Tel: 0756770843',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      height: 1.5,
                    ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        buttonTitle: 'Okay',
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Officer Login',
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
                const SizedBox(height: 40),
                const LabelWidget(label: 'Username'),
                TextFieldWidget(
                  hintText: 'johndoe',
                  controller: _usernameController,
                  suffixWidget: Icon(
                    Icons.person_outline,
                    size: 18,
                    color: Colors.black.withOpacity(0.65),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                const LabelWidget(label: 'Password'),
                TextFieldWidget(
                  hintText: 'Password@123',
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: !isClicked,
                  suffixWidget: GestureDetector(
                    onTap: () {
                      setState(() {
                        isClicked = !isClicked;
                      });
                    },
                    child: Icon(
                      isClicked
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 18,
                      color: Colors.black.withOpacity(0.65),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => _forgotPasswordDialog(),
                    child: const Text('Forgot Password?'),
                  ),
                ),
                const SizedBox(height: 20),
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
                      login();
                    }
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black.withOpacity(0.75),
                          ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const OfficerRegistration()),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
