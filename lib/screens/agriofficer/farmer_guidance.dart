import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/screens/agriofficer/agri_officer_menu.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Production {
  final int id;
  final DateTime date;
  final double quantity;

  Production({
    required this.id,
    required this.date,
    required this.quantity,
  });
}

class FarmerGuidance extends StatefulWidget {
  final int farmerId;
  final String farmerName;

  const FarmerGuidance({required this.farmerId, required this.farmerName});

  @override
  _FarmerGuidanceState createState() => _FarmerGuidanceState();
}

class _FarmerGuidanceState extends State<FarmerGuidance> {
  List<Production> production = [];
  String _selectedStatus = 'Seed';

  Future<Map<String, dynamic>> updateFarmerStatus() async {
    final String apiUrl =
        'http://127.0.0.1:5000/update_farmers_status/${widget.farmerId}';
    final response = await http.put(Uri.parse(apiUrl),
        body: jsonEncode({'status': _selectedStatus}));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update farmer status.');
    }
  }

  Future<void> _fetchProduction(int farmerID) async {
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:5000/production/$farmerID')); // replace with your API URL
    final List<dynamic> data = json.decode(response.body);
    setState(() {
      production = data
          .map((item) => Production(
                id: item['id'],
                date: DateTime.parse(item['date']),
                quantity: item['quantity'],
              ))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchProduction(widget.farmerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Details'),
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
      drawer: const AgriOfficerMenu(),
      body: Container(
        color: CustomColors.hazelColor,
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: SingleChildScrollView(
            // constraints: const BoxConstraints.expand(),
            child: Column(
              children: [
                Container(height: 30.0),
                Padding(
                  padding: const EdgeInsets.all(8.0), // Add desired padding
                  child: DropdownButtonFormField<String>(
                    value: _selectedStatus,
                    onChanged: (value) {
                      setState(() {
                        _selectedStatus = value!;
                        updateFarmerStatus();
                      });
                      //widget.onChanged(value!);
                    },
                    items: <String>['Seed', 'Maintain', 'Harvest']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Change Status',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(height: 30.0),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    widget.farmerName + "'s Production History",
                    style: const TextStyle(
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
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Quntity')),
                    ],
                    rows: production
                        .map((production) => DataRow(cells: [
                              DataCell(Text(production.id.toString())),
                              DataCell(Text(
                                  production.date.toString().substring(0, 10))),
                              DataCell(Text(production.quantity.toString())),
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
