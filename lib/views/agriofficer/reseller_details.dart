import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/configs/url_location.dart';
import 'package:agromate/models/reseller_model.dart';
import 'package:agromate/views/agriofficer/agri_officer_menu.dart';
import 'package:agromate/views/agriofficer/agriofficer_2_reseller.dart';
import 'package:agromate/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ResellerHistory extends StatefulWidget {
  const ResellerHistory({super.key});

  @override
  _ResellerHistoryState createState() => _ResellerHistoryState();
}

class _ResellerHistoryState extends State<ResellerHistory> {
  List<ResellerDetails> production = [];
  String status = "";
  String ResellerName = "";
  bool isDateSend = true;
  bool isenterresellerid = false;
  final ResellerId = TextEditingController();

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
    // _fetchProduction(widget.ResellerId);
    // _fetchStatus(widget.ResellerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reseller's History",
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
      drawer: const AgriOfficerMenu(),
      body: Container(
        color: CustomColors.hazelColor,
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(height: 30.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: AbsorbPointer(
                    absorbing: !isDateSend,
                    child: TextField(
                      controller: ResellerId,
                      onChanged: (value) {
                        // Check if the text field is filled
                        setState(() {
                          isenterresellerid = value.isNotEmpty;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: "Enter the reseller's Id",
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(height: 30.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                // child: ElevatedButton(
                //   onPressed: () {
        
                //   },
                //   child: const Text('Enter'),
                // ),
                child: ButtonWidget(
                  width: 300,
                  height: 65,
                  borderRadius: 10,
                  onPressed: () {
                    if (isenterresellerid) {
                      _fetchProduction(int.parse(ResellerId.text));
                    } else {
                      _showErrorDialog(context, "Please enter the id");
                    }
                  },
                  child: const Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonWidget(
                  width: 300,
                  height: 65,
                  borderRadius: 10,
                  onPressed: () {
                    if (isenterresellerid) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AgriOfficer_2_Reseller(ResellerId: int.parse(ResellerId.text)),
                        ),
                      );
                    } else {
                      _showErrorDialog(context, "Please enter the id");
                    }
                  },
                  child: const Text(
                    'Add Target Production',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "$ResellerName Resell History",
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
    );
  }

  void _showErrorDialog(BuildContext context, message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alert !"),
          content: Text(message), // Corrected parameter name
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
