import 'dart:convert';
import 'package:flutter_google_sign_in/model/NewsModel.dart';
import 'package:http/http.dart' as http;

class NewsApiService {
  final String apiUrl = 'http://10.0.2.2:8082/api/news';

  Future<List<NewsModel>> fetchNews() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      String utf8DecodedBody = utf8.decode(response.bodyBytes);
      List<dynamic> jsonData = json.decode(utf8DecodedBody);
      return jsonData.map((json) => NewsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
