// lib/services/machine_service.dart dosyasını güncelleyin.
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/machine_status.dart';
import '../models/full_machine_status.dart'; // Bu satırı ekleyin.
import '../models/process_control_command.dart'; // Bu satırı ekleyin.
import '../models/vnc_connection_info.dart'; // Bu satırı ekleyin.
import '../models/machine.dart'; // Bu satırı ekleyin.

class MachineService {
  final String _baseApiUrl = 'https://tekstilscada-api.com/api/Machine';

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Mevcut metodunuz:
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

  // Yeni eklenen metot
  Future<FullMachineStatus> getMachineDetail(int machineId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseApiUrl/$machineId/Detail'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return FullMachineStatus.fromJson(data);
    } else {
      throw Exception('Makine detayları yüklenemedi: ${response.statusCode}');
    }
  }

  // Yeni eklenen metot
  Future<void> sendControlCommand(ProcessControlCommand command) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$_baseApiUrl/Control'),
      headers: headers,
      body: jsonEncode(command.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Komut gönderilemedi: ${response.statusCode}');
    }
  }

  // Yeni eklenen metot
  Future<VncConnectionInfo> getVncConnectionInfo(int machineId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseApiUrl/$machineId/VncConnection'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return VncConnectionInfo.fromJson(data);
    } else {
      throw Exception(
        'VNC bağlantı bilgileri yüklenemedi: ${response.statusCode}',
      );
    }
  }

  // Yeni eklenen metot: Tüm makinelerin listesini çeker.
  Future<List<Machine>> getAllMachines() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseApiUrl/All'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Machine.fromJson(json)).toList();
    } else {
      throw Exception('Makine listesi yüklenemedi: ${response.statusCode}');
    }
  }
}
