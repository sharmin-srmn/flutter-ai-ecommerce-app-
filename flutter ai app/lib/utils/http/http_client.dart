// import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class THttpHelper {
  static const String _baseurl = '';

  //HELPER FUNCTION TO MAKE A GET REQUEST
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseurl/$endpoint'));
    return _handleResponse(response);
  }

  //HELPER FUNCTION TO MAKE A POST REQUEST
  static Future<Map<String, dynamic>> post(
      String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse('$_baseurl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  //HELPER FUNCTION TO MAKE A PUT REQUEST
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$_baseurl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  //HELPER FUNCTION TO MAKE A DELETE REQUEST
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$_baseurl/$endpoint'));
    return _handleResponse(response);
  }

  //HANDLE THE HTTP RESPONSE
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data : ${response.statusCode}');
    }
  }
}
