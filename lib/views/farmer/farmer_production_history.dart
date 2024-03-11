import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/configs/url_location.dart';
import 'package:agromate/models/farmer_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:agromate/views/farmer/farmer_menu.dart';

class FarmerHistory extends StatefulWidget {
  final int farmerId;

  FarmerHistory({required this.farmerId});

  @override
  _FarmerHistoryState createState() => _FarmerHistoryState();
}

class _FarmerHistoryState extends State<FarmerHistory> {
  List<Production> production = [];
  String status = "";
  String farmerName = "";

  Future<void> _fetchProduction(int farmerID) async {
    try {
      final response =
          await http.get(Uri.parse('${UrlLocation.Url}/production/$farmerID'));
      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['result'];
        final String name = jsonResponse['name'];
        setState(() {
          farmerName = name;
          production = data
              .map((item) => Production(
                    id: item['id'],
                    date: DateTime.parse(item['date']),
                    quantity: item['quantity'],
                  ))
              .toList();
        });
      } else {
        throw Exception('Failed to load production');
      }
    } catch (error) {
      print('Error fetching production: $error');
    }
  }

  Future<void> _fetchStatus(int farmerId) async {
    final response =
        await http.get(Uri.parse('${UrlLocation.Url}/farmer/$farmerId'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      String name = jsonResponse['name'];
      String status = jsonResponse['status'];
      setState(() {
        this.status = status;
        farmerName = name;
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProduction(widget.farmerId);
    _fetchStatus(widget.farmerId); // Fetch status and name
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your History',
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
              children: [
                Container(height: 30.0),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Hi, $farmerName",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  "Status: $status", // Display status
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Quantity')),
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
