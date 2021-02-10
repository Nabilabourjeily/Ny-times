import 'package:http/http.dart' as http;
import 'dart:io';
import '../app_config_constants.dart';

class ApiService {
  Future<http.Response> post(String apiUrl, payload) async {
    final String finalUrl = baseUrl + apiUrl;
    return await http.post(finalUrl, body: payload, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
  }

  Future<http.Response> get(String apiUrl) async {
    final String finalUrl = baseUrl + apiUrl;
    return await http.get(finalUrl);
  }
}
