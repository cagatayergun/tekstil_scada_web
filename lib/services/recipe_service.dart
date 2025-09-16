// lib/services/recipe_service.dart dosyasını oluşturun.
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/scada_recipe.dart';

class RecipeService {
  final String _baseApiUrl = 'https://tekstilscada-api.com/api/Recipe';

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Tüm reçeteleri çeken metod.
  Future<List<ScadaRecipe>> getAllRecipes() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseApiUrl/All'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ScadaRecipe.fromJson(json)).toList();
    } else {
      throw Exception('Reçeteler yüklenemedi: ${response.statusCode}');
    }
  }

  // Belirli bir reçeteyi ID ile çeken metod.
  Future<ScadaRecipe> getRecipeById(int id) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseApiUrl/$id'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return ScadaRecipe.fromJson(data);
    } else {
      throw Exception('Reçete yüklenemedi: ${response.statusCode}');
    }
  }

  Future<void> updateRecipeStep(
    int recipeId,
    ScadaRecipeStep updatedStep,
  ) async {
    final headers = await _getHeaders();
    final response = await http.put(
      Uri.parse('$_baseApiUrl/$recipeId/Step/${updatedStep.stepId}'),
      headers: headers,
      body: jsonEncode({
        'stepType': updatedStep.stepType,
        'parameters': updatedStep.parameters,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Reçete adımı güncellenemedi: ${response.statusCode}');
    }
  }
}
