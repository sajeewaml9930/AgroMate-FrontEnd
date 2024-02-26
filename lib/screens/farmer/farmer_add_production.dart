import 'package:agromate/screens/farmer/farmer_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddProduction extends StatefulWidget {
  final int farmerId;

  AddProduction({required this.farmerId});

  @override
  _AddProductionState createState() => _AddProductionState();
}

class _AddProductionState extends State<AddProduction> {
  final dateinput = TextEditingController();
  final quantity = TextEditingController();

  String selectedDate = "";

  bool isDateSend = false;

  Future<void> _postData(int id) async {
    final url = Uri.parse('http://127.0.0.1:5000/farmers/1/productions');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'date': dateinput,
      'quantity': quantity,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Success
    } else {
      // Error
    }
  }

  @override
  void dispose() {
    dateinput.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Production'),
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
        drawer: const FarmerMenu(),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(height: 30.0),
              Container(
                width: double.infinity,
                child: Text(
                  'Enter Your Production',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(height: 20.0),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Harvested Date',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: dateinput,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Enter Date",
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(formattedDate);
                      setState(() {
                        dateinput.text = formattedDate;
                      });
                      formattedDate = selectedDate;
                      //sendDate();
                      if (isDateSend) {
                        //_fetchData();
                      }
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
              Container(height: 60.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: quantity,
                  decoration: InputDecoration(
                    labelText: 'Harvest Quntity in Kilo',
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
              Container(height: 100.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _postData(widget.farmerId);
                  },
                  child: const Text('Enter'),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ));
  }
}
