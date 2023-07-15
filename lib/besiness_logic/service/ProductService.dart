import 'dart:convert';
import '../models/ProductModel.dart';
import 'package:http/http.dart' as http;
class ProductService{
Future<List<ProductModel>> fetchAllProduct() async {
     const String baseUrl = 'http://192.168.43.182:8036/api/admin/product/';
    final response = await http.get(Uri.parse('$baseUrl'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
    final List<ProductModel> products = jsonList
      .map((json) => ProductModel.fromJson(json))
      .toList();

  // Return the list of ClientModel objects
  return products;
    } else {
      throw Exception('client to fetch data');
    }
  }

}