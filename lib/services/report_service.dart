// lib/services/report_service.dart dosyasını güncelleyin.
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/alarm_report_item.dart';
import '../models/trend_data_point.dart';
import '../models/oee_data.dart'; // Bu satırı ekleyin.
import '../models/production_report_item.dart'; // Bu satırı ekleyin.
import '../models/action_log_entry.dart'; // Bu satırı ekleyin.
import '../models/manual_usage_report_item.dart'; // Bu satırı ekleyin.
import '../models/recipe_optimization_data.dart'; // Bu satırı ekleyin.

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

  // Mevcut metodunuz:
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

  // Mevcut metodunuz:
  Future<List<TrendDataPoint>> getTrendData(String parameterName) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseApiUrl/Report/GetTrendData?parameter=$parameterName'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => TrendDataPoint.fromJson(json)).toList();
    } else {
      throw Exception('Trend verisi yüklenemedi: ${response.statusCode}');
    }
  }

  // Yeni eklenen metot
  Future<OeeData> getOeeReportData() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseApiUrl/Report/GetOeeReport'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return OeeData.fromJson(data);
    } else {
      throw Exception('OEE rapor verisi yüklenemedi: ${response.statusCode}');
    }
  }

  // Yeni eklenen metot
  Future<List<ProductionReportItem>> getProductionReport() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseApiUrl/Report/GetProductionReport'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ProductionReportItem.fromJson(json)).toList();
    } else {
      throw Exception(
        'Üretim raporu verileri yüklenemedi: ${response.statusCode}',
      );
    }
  }

  // Yeni eklenen metot
  Future<List<ActionLogEntry>> getActionLogReport() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseApiUrl/Report/GetActionLogReport'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ActionLogEntry.fromJson(json)).toList();
    } else {
      throw Exception(
        'Eylem kaydı verileri yüklenemedi: ${response.statusCode}',
      );
    }
  }

  // Yeni eklenen metot
  Future<List<ManualUsageReportItem>> getManualUsageReport() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseApiUrl/Report/GetManualUsageReport'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ManualUsageReportItem.fromJson(json)).toList();
    } else {
      throw Exception(
        'Manuel kullanım verileri yüklenemedi: ${response.statusCode}',
      );
    }
  }

  // Yeni eklenen metot
  Future<List<RecipeOptimizationData>> getRecipeOptimizationReport() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseApiUrl/Report/GetRecipeOptimizationReport'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => RecipeOptimizationData.fromJson(json)).toList();
    } else {
      throw Exception(
        'Reçete optimizasyon verileri yüklenemedi: ${response.statusCode}',
      );
    }
  }
}
