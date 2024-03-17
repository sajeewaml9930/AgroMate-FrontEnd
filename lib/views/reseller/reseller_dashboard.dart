import 'package:agromate/views/Reseller/Reseller_home.dart';
import 'package:agromate/views/reseller/reseller_add_reselldetails.dart';
import 'package:agromate/views/reseller/reseller_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/configs/url_location.dart';
import 'package:agromate/views/widgets/button_widget.dart';

class ResellerDashBoard extends StatefulWidget {
  final int ResellerId;

  ResellerDashBoard({required this.ResellerId});

  @override
  _ResellerDashBoardState createState() => _ResellerDashBoardState();
}

class _ResellerDashBoardState extends State<ResellerDashBoard> {
  final dateinput = TextEditingController();
  String Price = "";
  String ResellerName = "";
  String quantity = "";
  String price = "";

  Future<void> _fetchPrice(int ResellerId) async {
    final response =
        await http.get(Uri.parse('${UrlLocation.Url}/Reseller/$ResellerId'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      String name = jsonResponse['name'];
      String Price = jsonResponse['Price'];
      setState(() {
        this.Price = Price;
        this.ResellerName = name;
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<void> _fetchweight(int ResellerId) async {
    final response = await http
        .get(Uri.parse('http://localhost:5000/o2r/$ResellerId'));
    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      // Ensure 'quantity' is converted to a string
      String quantity = jsonResponse['quantity'].toString();
      String price = jsonResponse['price'].toString();
      setState(() {
        this.quantity = quantity;
        this.price = price;
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  void dispose() {
    _fetchPrice(widget.ResellerId);
    _fetchweight(widget.ResellerId);
    dateinput.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // print(widget.ResellerId);
    _fetchPrice(widget.ResellerId);
    _fetchweight(widget.ResellerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResellerHomeScreen(
              ResellerId: widget.ResellerId,
            ),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Reseller DashBoard',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Your Target Price : ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 60,
                        width: 200.0, // set the desired width here
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Rs. $price",
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Your Target weight : ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 60,
                        width: 200.0, // set the desired width here
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '${quantity}kg',
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  ButtonWidget(
                    width: 300,
                    height: 65,
                    borderRadius: 10,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResellerAddProduction(
                            ResellerId: widget.ResellerId,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Add My Resell Details',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
