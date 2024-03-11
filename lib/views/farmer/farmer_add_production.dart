import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/configs/url_location.dart';
import 'package:agromate/views/farmer/farmer_menu.dart';
import 'package:agromate/views/widgets/alert_box_widget.dart';
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
    final url = Uri.parse('${UrlLocation.Url}/farmers/$id/productions');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'date': dateinput.text,
      'quantity': quantity.text,
    });

    final response = await http.post(url, headers: headers, body: body);
    final responseData = json.decode(response.body);

    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (context) => AlertBoxWidget(
          title: 'Success',
          content: Text.rich(
            TextSpan(
              text: responseData['success'],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    height: 1.5,
                  ),
            ),
            textAlign: TextAlign.center,
          ),
          buttonTitle: 'Okay',
          onPressed: () {
            Navigator.pop(context);
            dateinput.clear();
            quantity.clear();
          },
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertBoxWidget(
          title: 'Error',
          content: Text.rich(
            TextSpan(
              text: responseData['error'],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    height: 1.5,
                  ),
            ),
            textAlign: TextAlign.center,
          ),
          buttonTitle: 'Okay',
          onPressed: () => Navigator.pop(context),
        ),
      );
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
        title: const Text(
          'Add Production',
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(height: 30.0),
                const SizedBox(
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
                const SizedBox(height: 20),
                const Align(
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
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Enter Date",
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime(2000), // Restrict to today or before
                        lastDate: DateTime.now(),
                      );

                      if (pickedDate != null) {
                        print(pickedDate);
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(formattedDate);
                        setState(() {
                          dateinput.text = formattedDate;
                        });
                        formattedDate = selectedDate;
                        if (isDateSend) {
                          // Do something if date is sent
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
                    decoration: const InputDecoration(
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
