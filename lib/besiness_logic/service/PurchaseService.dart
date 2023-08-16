import 'dart:convert';
import 'package:fluttergenerator/besiness_logic/models/PurchaseModel.dart';
import 'package:http/http.dart' as http;


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
  Future<dynamic> deletePurchase(PurchaseModel purchaseModel) async {
    String jsonData = jsonEncode(purchaseModel);
    final response = await http.delete(
       Uri.parse('$baseUrl'),
      body:jsonData,
      headers: {'Content-Type': 'application/json'},
    );
  }

    Future<List<PurchaseModel>> fetchAllPurchase() async {
    final response = await http.get(Uri.parse('$baseUrl'));
      final List<dynamic> jsonList = json.decode(response.body);
   final List<PurchaseModel> items = jsonList.map((json) => PurchaseModel.fromJson(json)).toList();
  // Return the list of ClientModel objects
  return items;
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