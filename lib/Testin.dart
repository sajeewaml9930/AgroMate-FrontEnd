import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterFarmerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _registerFarmer();
      },
      child: Text('Register Farmer'),
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
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Register Farmer Button'),
      ),
      body: Center(
        child: RegisterFarmerButton(),
      ),
    ),
  ));
}
