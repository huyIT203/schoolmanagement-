import 'dart:convert';
import 'package:flutter_google_sign_in/model/classmodel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'http://10.0.2.2:8082/classes';

  Future<List<ClassModel>> fetchallClasses() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      String utf8DecodedBody = utf8.decode(response.bodyBytes);
      List<dynamic> jsonResponse = json.decode(utf8DecodedBody);
      return jsonResponse.map((json) => ClassModel.fromJson(json)).toList();
    } else {
      throw Exception('Lỗi khi tải dữ liệu: ${response.statusCode}');
    }
  }

  Future<ClassModel> fetchClasses(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      String utf8DecodedBody = utf8.decode(response.bodyBytes);
      return ClassModel.fromJson(jsonDecode(utf8DecodedBody));
    } else {
      throw Exception('Lỗi khi tải dữ liệu: ${response.statusCode}');
    }
  }
}
