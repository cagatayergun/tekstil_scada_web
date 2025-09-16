import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/machine_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MachineService {
  final String _baseApiUrl =
      'https://tekstilscada-api.com/api/Machine'; // API URL'inizi güncelleyin.

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Tüm makinelerin anlık durumunu çeken metod.
  Future<List<MachineStatus>> getMachineStatuses() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseApiUrl/Statuses'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => MachineStatus.fromJson(json)).toList();
    } else {
      throw Exception('Makinelerin durumu yüklenemedi: ${response.statusCode}');
    }
  }
}
