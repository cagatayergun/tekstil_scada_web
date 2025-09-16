import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/kpi_view_model.dart';

class ApiService {
  final String _baseApiUrl =
      'https://tekstilscada-api.com/api'; // API URL'inizi güncelleyin.

  // API'den token alarak yetkilendirilmiş istek gönderme.
  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Dashboard verilerini çekmek için fonksiyon.
  Future<List<KpiViewModel>> getDashboardData() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseApiUrl/Dashboard/GetKpis'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => KpiViewModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load dashboard data');
    }
  }
}
