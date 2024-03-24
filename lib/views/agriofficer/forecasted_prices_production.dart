import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/configs/url_location.dart';
import 'package:agromate/models/common.dart';
import 'package:agromate/views/agriofficer/agri_officer_home.dart';
import 'package:agromate/views/agriofficer/agri_officer_menu.dart';
import 'package:agromate/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  String selectedDate = "";

  bool isDateSend = false;
  int _selectedYear = 2024;
  int _selectedMonth = 1;
  int _selectedWeek = 1;

  List<DropdownMenuItem<int>> _buildYearItems() {
    List<DropdownMenuItem<int>> items = [];
    for (int year = 2022; year <= 2030; year++) {
      items.add(
        DropdownMenuItem(
          value: year,
          child: Text(year.toString()),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<int>> _buildMonthItems() {
    List<DropdownMenuItem<int>> items = [];
    for (int month = 1; month <= 12; month++) {
      items.add(
        DropdownMenuItem(
          value: month,
          child: Text(month.toString()),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<int>> _buildWeekItems() {
    List<DropdownMenuItem<int>> items = [];
    for (int week = 1; week <= 4; week++) {
      items.add(
        DropdownMenuItem(
          value: week,
          child: Text(week.toString()),
        ),
      );
    }
    return items;
  }

  Future<void> postDate(Date userData) async {
    final url = Uri.parse(
        '${UrlLocation.Url}/predict'); // Replace with your API endpoint URL
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = jsonEncode(userData.toJson());

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        //print('Data posted successfully');
        fetchData();
      } else {
        //print('Failed to post data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //print('Error posting data: $e');
    }
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('${UrlLocation.Url}/forecasted_prices_n_production'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        forecastedPrice = data['price'];
        forecasatedProduction = data['production'];
      });
      // Use price and production in your code as needed
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  void dispose() {
    //_fetchData();
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
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButton(
                          value: _selectedYear,
                          items: _buildYearItems(),
                          onChanged: (value) {
                            setState(() {
                              _selectedYear = value!;
                            });
                          },
                          isExpanded: true,
                          hint: const Text('Year'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButton(
                          value: _selectedMonth,
                          items: _buildMonthItems(),
                          onChanged: (value) {
                            setState(() {
                              _selectedMonth = value!;
                            });
                          },
                          isExpanded: true,
                          hint: const Text('Month'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButton(
                          value: _selectedWeek,
                          items: _buildWeekItems(),
                          onChanged: (value) {
                            setState(() {
                              _selectedWeek = value!;
                            });
                          },
                          isExpanded: true,
                          hint: const Text('Week'),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 60.0),
                ButtonWidget(
                  width: 300,
                  height: 65,
                  borderRadius: 10,
                  onPressed: () {
                    Date date = Date(
                        Year: _selectedYear.toString(),
                        Month: _selectedMonth.toString(),
                        Week: _selectedWeek.toString());
                    //print(date.Month + date.Week);
                    postDate(date);
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
                      "$forecasatedProduction Tones",
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
                      "Rs. $forecastedPrice",
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
                      "$forecastedPrice kg",
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
              ],
            ),
          ),
        ));
  }
}
