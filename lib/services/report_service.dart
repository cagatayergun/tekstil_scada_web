import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/alarm_report_item.dart';

class ReportService {
  final String _baseApiUrl = 'https://tekstilscada-api.com/api';

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Alarm rapor verilerini çeken fonksiyon.
  Future<List<AlarmReportItem>> getAlarmReportData() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseApiUrl/Report/GetAlarmReport'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => AlarmReportItem.fromJson(json)).toList();
    } else {
      throw Exception(
        'Alarm rapor verileri yüklenemedi: ${response.statusCode}',
      );
    }
  }
}
