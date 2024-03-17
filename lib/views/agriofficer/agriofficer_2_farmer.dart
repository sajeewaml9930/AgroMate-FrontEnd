import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/configs/url_location.dart';
import 'package:agromate/views/agriofficer/agri_officer_menu.dart';
import 'package:agromate/views/widgets/alert_box_widget.dart';
import 'package:agromate/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgriOfficer_2_Farmer extends StatefulWidget {
  final int farmerId;

  const AgriOfficer_2_Farmer({super.key, required this.farmerId});

  @override
  _AgriOfficer_2_FarmerState createState() => _AgriOfficer_2_FarmerState();
}

class _AgriOfficer_2_FarmerState extends State<AgriOfficer_2_Farmer> {
  final dateinput = TextEditingController();
  final quantity = TextEditingController();

  String selectedDate = "";

  bool isDateSend = false;
  bool isenterquantity = false;

  // Future<void> _postData(int id) async {
  //   final url = Uri.parse('${UrlLocation.Url}o2f_production/add');
  //   final headers = {'Content-Type': 'application/json'};
  //   final body = json.encode({
  //     'date': dateinput.text,
  //     'quantity': quantity.text,
  //   });

  //   final response = await http.post(url, headers: headers, body: body);
  //   final responseData = json.decode(response.body);

  //   if (response.statusCode == 201) {
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertBoxWidget(
  //         title: 'Success',
  //         content: Text.rich(
  //           TextSpan(
  //             text: responseData['success'],
  //             style: Theme.of(context).textTheme.bodyMedium!.copyWith(
  //                   height: 1.5,
  //                 ),
  //           ),
  //           textAlign: TextAlign.center,
  //         ),
  //         buttonTitle: 'Okay',
  //         onPressed: () {
  //           Navigator.pop(context);
  //           dateinput.clear();
  //           quantity.clear();
  //         },
  //       ),
  //     );
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertBoxWidget(
  //         title: 'Error',
  //         content: Text.rich(
  //           TextSpan(
  //             text: responseData['error'],
  //             style: Theme.of(context).textTheme.bodyMedium!.copyWith(
  //                   height: 1.5,
  //                 ),
  //           ),
  //           textAlign: TextAlign.center,
  //         ),
  //         buttonTitle: 'Okay',
  //         onPressed: () => Navigator.pop(context),
  //       ),
  //     );
  //   }
  // }
  Future<void> _postData(int id) async {
  final url = Uri.parse('${UrlLocation.Url}/o2f_production/add');
  final headers = {'Content-Type': 'application/json'};
  final body = json.encode({
    'quantity': quantity.text,
    'farmer_id': id.toString(), // Assuming the id here is the farmer_id
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
            text: responseData['message'], // Adjusted key to 'message'
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
            text: responseData['error'], // Adjusted key to 'error'
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
      drawer: const AgriOfficerMenu(),
      body: Container(
        color: CustomColors.hazelColor,
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(height: 30.0),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Enter Targrt for Production \n(Farmer ID: ${widget.farmerId})',
                  style: const TextStyle(
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
                    'Date',
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
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      isDateSend = true;
                      setState(() {
                        dateinput.text = formattedDate;
                      });
                      formattedDate = selectedDate;
                      if (isDateSend) {
                        // Do something if date is sent
                      }
                    } else {}
                  },
                ),
              ),
              Container(height: 60.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: isDateSend
                      ? () {}
                      : () =>
                          _showErrorDialog(context, "Please enter the date."),
                  child: AbsorbPointer(
                    absorbing: !isDateSend,
                    child: TextField(
                      controller: quantity,
                      onChanged: (value) {
                        // Check if the text field is filled
                        setState(() {
                          isenterquantity = value.isNotEmpty;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter Targrt Production in Kilo',
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
              Container(height: 50.0),
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
                    if (isDateSend) {
                      if (isenterquantity) {
                        _postData(widget.farmerId);
                        print(dateinput.text);
                      } else {
                        _showErrorDialog(context,
                            "Please enter targrt production in Kilo");
                      }
                    } else {
                      _showErrorDialog(context, "Please enter the date.");
                    }
                  },
                  child: const Text(
                    'Enter',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
