import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/PurchaseModel.dart';

class PurchaseService {        
  static const String baseUrl = 'http://192.168.43.182:8036/api/admin/purchase/';

  Future<String> fetchData() async {
    final response = await http.get(Uri.parse('$baseUrl'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<void> postData(PurchaseModel purchaseModel) async {
    String jsonData = jsonEncode(purchaseModel);
    final response = await http.post(
      Uri.parse('$baseUrl'),
      body:jsonData,
      headers: {'Content-Type': 'application/json'},
    );
  }
}