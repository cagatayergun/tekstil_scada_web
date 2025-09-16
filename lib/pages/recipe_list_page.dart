// lib/pages/recipe_list_page.dart dosyasını güncelleyin.
import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/scada_recipe.dart';
import 'package:tekstil_scada_web/services/recipe_service.dart';
import 'recipe_detail_page.dart'; // Bu satırı ekleyin.

class RecipeListPage extends StatefulWidget {
  final String machineType;

  const RecipeListPage({Key? key, required this.machineType}) : super(key: key);

  @override
  _RecipeListPageState createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  late Future<List<ScadaRecipe>> _recipes;
  final RecipeService _recipeService = RecipeService();

  @override
  void initState() {
    super.initState();
    _recipes = _recipeService.getAllRecipes().then((allRecipes) {
      return allRecipes
          .where((recipe) => recipe.machineType == widget.machineType)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.machineType} Reçeteleri')),
      body: FutureBuilder<List<ScadaRecipe>>(
        future: _recipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Reçete bulunamadı.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final recipe = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.receipt),
                    title: Text(recipe.name),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipeDetailPage(recipeId: recipe.id),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
