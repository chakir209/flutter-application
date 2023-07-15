import 'dart:convert';
import '../models/TagModel.dart';
import 'package:http/http.dart' as http;
class TagService{
Future<List<TagModel>> fetchAllTag() async {
     const String baseUrl = 'http://192.168.43.182:8036/api/admin/Tag/';
    final response = await http.get(Uri.parse('$baseUrl'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
    final List<TagModel> tags = jsonList
      .map((json) => TagModel.fromJson(json))
      .toList();

  // Return the list of TagModel objects
  return tags;
    } else {
      throw Exception('Tag to fetch data');
    }
  }

}