import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';

class UserService {
  final String _baseApiUrl = 'https://tekstilscada-api.com/api';

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<UserProfile> getUserProfile() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseApiUrl/User/GetProfile'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return UserProfile.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Kullanıcı profili yüklenemedi: ${response.statusCode}');
    }
  }
}
