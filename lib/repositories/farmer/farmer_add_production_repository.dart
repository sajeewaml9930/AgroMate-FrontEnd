import 'package:http/http.dart' as http;
import 'dart:convert';

class FarmerAddProductionRepository {
  Future<void> postData(int farmerId, String date, String quantity) async {
    final url = Uri.parse('http://127.0.0.1:5000/farmers/$farmerId/productions');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'date': date,
      'quantity': quantity,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Success
    } else {
      // Error
    }
  }
}
