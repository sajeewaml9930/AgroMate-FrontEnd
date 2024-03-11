import 'package:agromate/views/farmer/farmer_home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/configs/url_location.dart';
import 'package:agromate/views/farmer/farmer_add_production.dart';
import 'package:agromate/views/farmer/farmer_menu.dart';
import 'package:agromate/views/farmer/farmer_production_history.dart';
import 'package:agromate/views/widgets/button_widget.dart';

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
  String quantity = "";

  Future<void> _fetchStatus(int farmerId) async {
    final response =
        await http.get(Uri.parse('${UrlLocation.Url}/farmer/$farmerId'));
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

  Future<void> _fetchweight(int farmerId) async {
  final response = await http
      .get(Uri.parse('http://localhost:5000/o2fProduction/$farmerId'));
  if (response.statusCode == 201) {
    final jsonResponse = json.decode(response.body);
    // Ensure 'quantity' is converted to a string
    String quantity = jsonResponse['quantity'].toString();
    setState(() {
      this.quantity = quantity;
    });
  } else {
    throw Exception('Failed to fetch data');
  }
}


  @override
  void dispose() {
    _fetchStatus(widget.farmerId);
    _fetchweight(widget.farmerId);
    dateinput.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print(widget.farmerId);
    _fetchStatus(widget.farmerId);
    _fetchweight(widget.farmerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FarmerHomeScreen(
              farmerId: widget.farmerId,
            ),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Farmer DashBoard',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
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
          centerTitle: true,
          backgroundColor: CustomColors.greenColor,
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.arrow_back),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //   ),
          // ],
        ),
        drawer: FarmerMenu(farmerId: widget.farmerId),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'You should : ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
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
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Your Target Production : ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
                            '${quantity}kg',
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  ButtonWidget(
                    width: 300,
                    height: 65,
                    borderRadius: 10,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddProduction(
                            farmerId: widget.farmerId,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Add My Production',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
