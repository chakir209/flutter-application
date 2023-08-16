import 'dart:convert';

import 'package:fluttergenerator/besiness_logic/models/ClientModel.dart';
import 'package:http/http.dart' as http;
class ClientService{
Future<List<ClientModel>> fetchAllClient() async {
     const String baseUrl = 'http://192.168.43.182:8036/api/admin/client/';
    final response = await http.get(Uri.parse('$baseUrl'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
    final List<ClientModel> clients = jsonList
      .map((json) => ClientModel.fromJson(json))
      .toList();

  // Return the list of ClientModel objects
  return clients;
    } else {
      throw Exception('client to fetch data');
    }
  }

}