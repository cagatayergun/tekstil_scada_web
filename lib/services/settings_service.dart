import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/machine_settings.dart';
import '../models/cost_parameter.dart'; // Bu satırın ekli olduğundan emin olun.
import 'package:tekstil_scada_web/models/alarm_definition.dart';
import '../models/plc_operator.dart'; // Bu satırı ekleyin.

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

  // Yeni eklenen metot
  Future<List<AlarmDefinition>> getAlarmDefinitions() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseApiUrl/Settings/GetAlarmDefinitions'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => AlarmDefinition.fromJson(json)).toList();
    } else {
      throw Exception(
        'Alarm tanımlamaları yüklenemedi: ${response.statusCode}',
      );
    }
  }

  // Yeni eklenen metot
  Future<List<PlcOperator>> getPlcOperators() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseApiUrl/Settings/GetPlcOperators'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => PlcOperator.fromJson(json)).toList();
    } else {
      throw Exception(
        'PLC operatör verileri yüklenemedi: ${response.statusCode}',
      );
    }
  }
}
