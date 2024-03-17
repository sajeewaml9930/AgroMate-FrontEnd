import 'package:agromate/views/agriofficer/agri_officer_home.dart';
import 'package:agromate/views/agriofficer/agriofficer_2_farmer.dart';
import 'package:agromate/views/agriofficer/agriofficer_2_reseller.dart';
import 'package:agromate/views/agriofficer/farmer_details.dart';
import 'package:agromate/views/agriofficer/forecasted_prices_production.dart';
import 'package:agromate/views/agriofficer/reseller_details.dart';
import 'package:agromate/views/home.dart';
import 'package:flutter/material.dart';

class AgriOfficerMenu extends StatelessWidget {
  const AgriOfficerMenu({Key? key}) : super(key: key);

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to sign out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sign Out'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Text(
              'Menu',
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AgriOfficerHomeScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.ad_units),
            title: const Text('Farmer Details'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FarmerHistory()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box),
            title: const Text('AgriOfficer to Reseller'),
            onTap: () {
              Navigator.pop(context);
              _agriofficer2reseller(context, "Please enter the date.");
            },
          ),
          ListTile(
            leading: const Icon(Icons.ad_units),
            title: const Text('Reseller Details'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ResellerHistory()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box),
            title: const Text('AgriOfficer to Farmer'),
            onTap: () {
              Navigator.pop(context);
              _agriofficer2farmer(context, "Please enter the date.");
            },
          ),
          ListTile(
            leading: const Icon(Icons.storage),
            title: const Text('Forecasted Prices n Production'),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) =>
              //           const forecasted_prices_n_production()),
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('sign Out'),
            onTap: () {
              Navigator.pop(context);
              _showSignOutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _agriofficer2farmer(BuildContext context, message) {
    TextEditingController _textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("AgriOfficer to Farmer"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textFieldController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter an integer'),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    // You can add your validation logic here
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AgriOfficer_2_Farmer(
                            farmerId: int.parse(_textFieldController.text),
                          )),
                );
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _agriofficer2reseller(BuildContext context, message) {
    TextEditingController _textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("AgriOfficer to Reseller"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textFieldController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter an integer'),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    // You can add your validation logic here
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AgriOfficer_2_Reseller(
                            ResellerId: int.parse(_textFieldController.text),
                          )),
                );
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
