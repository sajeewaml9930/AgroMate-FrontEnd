import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/configs/url_location.dart';
import 'package:agromate/views/reseller/reseller_menu.dart';
import 'package:agromate/views/widgets/alert_box_widget.dart';
import 'package:agromate/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResellerAddProduction extends StatefulWidget {
  final int ResellerId;

  const ResellerAddProduction({super.key, required this.ResellerId});

  @override
  // ignore: library_private_types_in_public_api
  _ResellerAddProductionState createState() => _ResellerAddProductionState();
}

class _ResellerAddProductionState extends State<ResellerAddProduction> {
  final dateinput = TextEditingController();
  final quantity = TextEditingController();
  final price = TextEditingController();

  String selectedDate = "";

  bool isDateSend = false;
  bool isenterquantity = false;
  bool isenterprice = false;

  Future<void> _postData(int id) async {
    final url = Uri.parse('${UrlLocation.Url}/reseller/$id/resellDetail');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'date': dateinput.text,
      'quantity': quantity.text,
      'price': price.text,
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
            price.clear();
            isDateSend = false;
            isenterquantity = false;
            isenterprice = false;
          },
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertBoxWidget(
          title: 'Alert !',
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
          'Add Resell Details',
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
      drawer: ResellerMenu(
        ResellerId: widget.ResellerId,
      ),
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
                    'Add Resell Details',
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
                          labelText: 'Reseller Quantity in Kilo',
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
                  child: GestureDetector(
                    onTap: isenterquantity
                        ? () {}
                        : () => _showErrorDialog(
                            context, "Please enter the price."),
                    child: AbsorbPointer(
                      absorbing: !isenterquantity,
                      child: TextField(
                        controller: price,
                        onChanged: (value) {
                          // Check if the text field is filled
                          setState(() {
                            isenterprice = value.isNotEmpty;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Resell Price in Rs.',
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
                  child: ButtonWidget(
                    width: 300,
                    height: 65,
                    borderRadius: 10,
                    onPressed: () {
                      if (isDateSend) {
                        if (isenterquantity) {
                          if (isenterprice) {
                            _postData(widget.ResellerId);
                          } else {
                            _showErrorDialog(
                                context, "Please enter the Price.");
                          }
                        } else {
                          _showErrorDialog(context,
                              "Please enter the harvest Quantity in Kilo.");
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
