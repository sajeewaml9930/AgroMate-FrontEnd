import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/configs/url_location.dart';
import 'package:agromate/models/farmer_model.dart';
import 'package:agromate/views/agriofficer/agri_officer_menu.dart';
import 'package:agromate/views/agriofficer/farmer_guidance.dart';
import 'package:agromate/views/home.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FarmerDetails extends StatefulWidget {
  const FarmerDetails({super.key});

  @override
  _FarmerDetailsState createState() => _FarmerDetailsState();
}

class _FarmerDetailsState extends State<FarmerDetails> {
  List<Farmer> farmers = [];

  Future<void> _fetchFarmers() async {
    final response = await http.get(Uri.parse(
        '${UrlLocation.Url}/farmers')); // replace with your API URL
    final List<dynamic> data = json.decode(response.body);
    setState(() {
      farmers = data
          .map((item) => Farmer(
                id: item['id'],
                name: item['name'],
                status: item['status'],
                lastProduction: item['last_production'] != null
                    ? item['last_production']['date']
                    : 'N/A',
              ))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchFarmers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Farmer Details',
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
      drawer: const AgriOfficerMenu(),
      body: Container(
        color: CustomColors.hazelColor,
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Farmer Details Table',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(height: 30.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Last Production')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: farmers
                        .map((farmer) => DataRow(cells: [
                              DataCell(Text(farmer.id.toString())),
                              DataCell(Text(farmer.name)),
                              DataCell(Text(farmer.status)),
                              DataCell(Text(farmer.lastProduction)),
                              DataCell(
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle button press for this farmer
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FarmerGuidance(
                                            farmerId: farmer.id,
                                            farmerName: farmer.name),
                                      ),
                                    );
                                  },
                                  child: const Text('Change'),
                                ),
                              ),
                            ]))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
