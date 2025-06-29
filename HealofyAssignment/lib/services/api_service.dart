import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/content_model.dart';

class ApiService {
  static Future<List<ContentModel>> fetchContents() async {
    final response = await http.get(
      Uri.parse(
        'https://afsarhealofy.github.io/flutterapitest/flutterapitest.json',
      ),
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final contents = jsonBody['data']['contents'] as List;
      return contents.map((item) => ContentModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load contents');
    }
  }
}
