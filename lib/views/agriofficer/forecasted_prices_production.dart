import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/configs/url_location.dart';
import 'package:agromate/views/agriofficer/agri_officer_home.dart';
import 'package:agromate/views/agriofficer/agri_officer_menu.dart';
import 'package:agromate/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class forecasted_prices_n_production extends StatefulWidget {
  const forecasted_prices_n_production({super.key});

  @override
  _forecasted_prices_n_productionState createState() =>
      _forecasted_prices_n_productionState();
}

class _forecasted_prices_n_productionState
    extends State<forecasted_prices_n_production> {
  final dateinput = TextEditingController();
  double forecastedPrice = 0;
  double forecasatedProduction = 0;
  double forecastedWeight = 0;

  String selectedDate = "";

  bool isDateSend = false;

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
            'OFFICER FORECASTING',
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
                builder: (context) => const AgriOfficerHomeScreen(),
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(height: 30.0),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Forecasted Value',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(height: 20.0),
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
                ButtonWidget(
                  width: 300,
                  height: 65,
                  borderRadius: 10,
                  // Inside onPressed callback of the Forecast button
                  onPressed: () async {
                    if (dateinput.text.isNotEmpty) {
                      // Prepare the request body
                      Map<String, dynamic> requestData = {
                        'date': dateinput.text,
                      };

                      // Send HTTP POST request to the Flask server
                      var response = await http.post(
                        Uri.parse('${UrlLocation.Url}/predict'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(requestData),
                      );

                      if (response.statusCode == 200) {
                        // Parse the response JSON
                        var responseData = json.decode(response.body);

                        // Update UI with received forecasted values
                        setState(() {
                          forecastedPrice =
                              responseData['Ash_Plantain_LCVEG_1kg'];
                          forecasatedProduction = responseData['Production'];
                          forecastedWeight = responseData['Resell_weight'];
                        });
                      } else {
                        // Handle error response
                        print(
                            'Failed to get forecast. Error: ${response.statusCode}');
                      }
                    } else {
                      // Handle case where no date is selected
                      print('Please select a date');
                    }
                  },
                  child: const Text(
                    'Forecast',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(height: 60.0),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Production For the Farmer',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70, // add this line
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "${forecasatedProduction.toStringAsFixed(2)} Tones",
                      // '$productionValue Tonne',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(height: 30.0),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Price for the Reseller',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70, // add this line
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Rs. ${forecastedPrice.toStringAsFixed(2)}",
                      //'Rs. $priceValue',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(height: 30.0),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Sell Weight for the Reseller',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70, // add this line
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "${forecastedWeight.toStringAsFixed(2)} kg",
                      //'Rs. $priceValue',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ));
  }
}
