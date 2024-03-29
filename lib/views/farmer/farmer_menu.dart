import 'package:agromate/views/farmer/farmer_add_production.dart';
import 'package:agromate/views/farmer/farmer_dashboard.dart';
import 'package:agromate/views/farmer/farmer_home.dart';
import 'package:agromate/views/farmer/farmer_production_history.dart';
import 'package:agromate/views/home.dart';
import 'package:flutter/material.dart';

class FarmerMenu extends StatelessWidget {
  final int farmerId;
  const FarmerMenu({Key? key, required this.farmerId}) : super(key: key);

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
                MaterialPageRoute(
                    builder: (context) => FarmerHomeScreen(farmerId: farmerId)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('My Dashboard'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FarmerDashBoard(farmerId: farmerId)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box),
            title: const Text('Add My Production'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProduction(farmerId: farmerId)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('My Prduction History'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FarmerHistory(farmerId: farmerId)),
              );
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
}
