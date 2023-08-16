import 'dart:convert';
import 'package:fluttergenerator/besiness_logic/models/PurchaseItemsModel.dart';
import 'package:http/http.dart' as http;

class PurchaseServiceItems {        
  static const String baseUrl = 'http://192.168.43.182:8036/api/admin/purchaseItem/';

  Future<List<PurchaseItemModel>> fetchPurchaseItems() async {
    final response = await http.get(Uri.parse('$baseUrl'));
      final List<dynamic> jsonList = json.decode(response.body);
   final List<PurchaseItemModel> items = jsonList.map((json) => PurchaseItemModel.fromJson(json)).toList();


  // Return the list of ClientModel objects
  return items;
  }
  Future<dynamic> deletePurchaseItems(PurchaseItemModel purchaseItemModel) async {
    String jsonData = jsonEncode(purchaseItemModel);
    final response = await http.delete(
       Uri.parse('$baseUrl'),
      body:jsonData,
      headers: {'Content-Type': 'application/json'},
    );
  // Return the list of ClientModel objects
  }
  Future<dynamic> updatedPurchaseItem(PurchaseItemModel purchaseItemModel) async {
  String jsonData = jsonEncode(purchaseItemModel);
  final response = await http.put(
    Uri.parse('$baseUrl'),
    body: jsonData,
    headers: {'Content-Type': 'application/json'},
  );

  // Return the response or relevant data
  return response.body; // You can return the response body or any other relevant data
}

  Future<void> savePurchaseItems(PurchaseItemModel purchaseItemModel) async {
    String jsonData = jsonEncode(purchaseItemModel);
    final response = await http.post(
      Uri.parse('$baseUrl'),
      body:jsonData,
      headers: {'Content-Type': 'application/json'},
    );
  }
}