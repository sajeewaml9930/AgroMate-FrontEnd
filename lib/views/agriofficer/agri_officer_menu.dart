import 'package:agromate/views/agriofficer/farmer_details.dart';
import 'package:agromate/views/agriofficer/forecasted_prices_production.dart';
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
                // Add sign-out logic here
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const MyApp()),
                // );
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
              'Agri Officer Menu',
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.home),
          //   title: Text('Home'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => Home()),
          //     );
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.ad_units),
            title: const Text('Farmer Details'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FarmerDetails()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.storage),
            title: const Text('Forecasted Prices n Production'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const forecasted_prices_n_production()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('sign Out'),
            onTap: () {
              _showSignOutDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
