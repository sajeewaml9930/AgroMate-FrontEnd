import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/screens/farmer/farmer_add_production.dart';
import 'package:agromate/screens/farmer/farmer_menu.dart';
import 'package:agromate/screens/farmer/farmer_production_history.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FarmerDashBoard extends StatefulWidget {
  final int farmerId;

  FarmerDashBoard({required this.farmerId});

  @override
  _FarmerDashBoardState createState() => _FarmerDashBoardState();
}

class _FarmerDashBoardState extends State<FarmerDashBoard> {
  final dateinput = TextEditingController();
  String status = "";
  String farmerName = "";

  Future<void> _fetchStatus(int farmerId) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:5000/farmer/$farmerId'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      String name = jsonResponse['name'];
      String status = jsonResponse['status'];
      setState(() {
        this.status = status;
        this.farmerName = name;
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  void dispose() {
    _fetchStatus(widget.farmerId);
    dateinput.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print(widget.farmerId);
    _fetchStatus(widget.farmerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer DashBoard'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      drawer: const FarmerMenu(),
      body: Container(
        color: CustomColors.hazelColor,
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        children: [
                          Text(
                            'You should : ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        SizedBox(
                          height: 60,
                          width: 200.0, // set the desired width here
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              status,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              Container(height: 100.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddProduction(
                            farmerId: widget.farmerId,
                          ),
                        ));
                  },
                  child: const Text('Add Production'),
                ),
              ),
              Container(height: 50.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FarmerHistory(
                                farmerId: widget.farmerId,
                                farmerName: farmerName,
                              )),
                    );
                  },
                  child: const Text('Your History'),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
