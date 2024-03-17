import 'package:agromate/views/home.dart';
import 'package:agromate/views/reseller/reseller_add_reselldetails.dart';
import 'package:agromate/views/reseller/reseller_dashboard.dart';
import 'package:agromate/views/reseller/reseller_home.dart';
import 'package:agromate/views/reseller/reseller_reselldetails_history.dart';
import 'package:flutter/material.dart';

class ResellerMenu extends StatelessWidget {
  final int ResellerId;
  const ResellerMenu({
    Key? key,
    required this.ResellerId,
  }) : super(key: key);
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
                    builder: (context) =>
                        ResellerHomeScreen(ResellerId: ResellerId)),
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
                    builder: (context) =>
                        ResellerDashBoard(ResellerId: ResellerId)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box),
            title: const Text('Add My Resell Details'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResellerAddProduction(
                          ResellerId: ResellerId,
                        )),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('My Resell History'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ResellerHistory(ResellerId: ResellerId)),
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
