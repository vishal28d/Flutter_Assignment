import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const _baseUrl = "https://api.mytravaly.com/public/v1/";
  static const _authToken = "71523fdd8d26f585315b4233e39d9263";

  static Future<List<dynamic>> fetchHotels({
    required String visitorToken,
    String country = "India",
    String state = "Maharashtra",
    String city = "Mumbai",
  }) async {
    final url = Uri.parse(_baseUrl);

    final headers = {
      'authtoken': _authToken,
      'visitortoken': visitorToken,
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "action": "popularStay",
      "popularStay": {
        "limit": 10,
        "entityType": "Any",
        "filter": {
          "searchType": "byCity",
          "searchTypeInfo": {
            "country": country,
            "state": state,
            "city": city,
          }
        },
        "currency": "INR"
      }
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["status"] == true && data["data"] != null) {
        return data["data"];
      } else {
        throw Exception("No hotels found");
      }
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  }
}
