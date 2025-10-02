import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationService {
  static Future<List<String>> search(String query) async {
    if (query.isEmpty) return [];

    final url = Uri.parse(
      "https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5",
    );

    final response = await http.get(url, headers: {
      'User-Agent': 'bibo_erp/1.0 (bibo@email.com)',
    });

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map<String>((place) => place["display_name"] as String).toList();
    } else {
      throw Exception("Failed to fetch locations");
    }
  }
}
