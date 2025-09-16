import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/machine_settings.dart';
import '../models/cost_parameter.dart'; // Bu satırın ekli olduğundan emin olun.

class SettingsService {
  final String _baseApiUrl = 'https://tekstilscada-api.com/api';

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<MachineSettings>> getMachineSettings() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseApiUrl/Settings/GetMachineSettings'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => MachineSettings.fromJson(json)).toList();
    } else {
      throw Exception('Makine ayarları yüklenemedi: ${response.statusCode}');
    }
  }

  Future<List<CostParameter>> getCostParameters() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseApiUrl/Settings/GetCostParameters'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => CostParameter.fromJson(json)).toList();
    } else {
      throw Exception(
        'Maliyet parametreleri yüklenemedi: ${response.statusCode}',
      );
    }
  }
}
