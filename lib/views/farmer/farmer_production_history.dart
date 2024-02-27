import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/models/farmer_model.dart';
import 'package:flutter/material.dart';
//import 'OfficerMenu.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



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
  //String _selectedStatus = 'Seed';

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
  Future<void> _fetchStatus(int farmerId) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:5000/farmer/$farmerId'));
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Details'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
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
      //drawer: Menu(),
      body: Container(
        color: CustomColors.hazelColor,
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: SingleChildScrollView(
            // constraints: BoxConstraints.expand(),
            child: Column(
              children: [
                Container(height: 30.0),
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
