import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/show_model.dart';

class ApiService {
  static const String baseUrl = 'https://api.tvmaze.com/shows';

  static Future<List<Show>> fetchShows() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Show.fromJson(e)).toList();
    }
    throw Exception('Gagal load daftar show');
  }

  static Future<Show> fetchShowDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Show.fromJson(jsonDecode(response.body));
    }
    throw Exception('Gagal load detail show');
  }
}