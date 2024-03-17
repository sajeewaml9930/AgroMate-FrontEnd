import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/configs/url_location.dart';
import 'package:agromate/models/reseller_model.dart';
import 'package:agromate/views/reseller/reseller_menu.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ResellerHistory extends StatefulWidget {
  final int ResellerId;

  const ResellerHistory({super.key, required this.ResellerId});

  @override
  _ResellerHistoryState createState() => _ResellerHistoryState();
}

class _ResellerHistoryState extends State<ResellerHistory> {
  List<ResellerDetails> production = [];
  String status = "";
  String ResellerName = "";

  Future<void> _fetchProduction(int resellerID) async {
    try {
      final response = await http.get(
          Uri.parse('${UrlLocation.Url}/reseller/reselldetail/$resellerID'));
      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['result'];
        final String name = jsonResponse['name'];
        setState(() {
          ResellerName = name;
          production = data
              .map((item) => ResellerDetails(
                    id: item['id'],
                    date: DateTime.parse(item['date']),
                    quantity: item['quantity'],
                    price: double.parse(item['price']), // Parse 'price' to int
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

  // Future<void> _fetchStatus(int ResellerId) async {
  //   final response =
  //       await http.get(Uri.parse('${UrlLocation.Url}/Reseller/$ResellerId'));
  //   if (response.statusCode == 200) {
  //     final jsonResponse = json.decode(response.body);
  //     String name = jsonResponse['name'];
  //     setState(() {
  //       ResellerName = name;
  //     });
  //   } else {
  //     throw Exception('Failed to fetch data');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _fetchProduction(widget.ResellerId);
    // _fetchStatus(widget.ResellerId);
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
      drawer: ResellerMenu(ResellerId: widget.ResellerId),
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
                    "Hi, $ResellerName",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Text(
                //   "Status: $status", // Display status
                //   style: const TextStyle(
                //     fontSize: 18,
                //     color: Colors.black,
                //   ),
                // ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Quantity')),
                      DataColumn(label: Text('Price')),
                    ],
                    rows: production
                        .map((production) => DataRow(cells: [
                              DataCell(Text(production.id.toString())),
                              DataCell(Text(
                                  production.date.toString().substring(0, 10))),
                              DataCell(Text(production.quantity.toString())),
                              DataCell(Text(production.price.toString())),
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
