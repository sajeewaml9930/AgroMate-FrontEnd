import 'package:flutter/material.dart';
//import 'OfficerMenu.dart';
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

class FarmerHistory extends StatefulWidget {
  final int farmerId;
  final String farmerName;

  FarmerHistory({required this.farmerId, required this.farmerName});

  @override
  _FarmerHistoryState createState() => _FarmerHistoryState();
}

class _FarmerHistoryState extends State<FarmerHistory> {
  List<Production> production = [];
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

  @override
  void initState() {
    super.initState();
    _fetchProduction(widget.farmerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer Details'),
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
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      //drawer: Menu(),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [
            Container(height: 30.0),    
            Container(height: 30.0),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Hi, "+ widget.farmerName,
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
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Quntity')),
              
                ],
                rows: production
                    .map((production) => DataRow(cells: [
                          DataCell(Text(production.id.toString())),
                          DataCell(Text(production.date.toString().substring(0, 10))),
                          DataCell(Text(production.quantity.toString())),
                          
                        ]))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
