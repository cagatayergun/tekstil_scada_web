// lib/pages/recipe_detail_page.dart dosyasını güncelleyin.
import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/scada_recipe.dart';
import 'package:tekstil_scada_web/services/recipe_service.dart';
import 'recipe_step_designer_page.dart'; // Bu satırı ekleyin.

class RecipeDetailPage extends StatefulWidget {
  final int recipeId;

  const RecipeDetailPage({Key? key, required this.recipeId}) : super(key: key);

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late Future<ScadaRecipe> _recipe;
  final RecipeService _recipeService = RecipeService();

  @override
  void initState() {
    super.initState();
    _recipe = _recipeService.getRecipeById(widget.recipeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reçete Detayı'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      RecipeStepDesignerPage(recipeId: widget.recipeId),
                ),
              );
            },
            tooltip: 'Adımları Düzenle',
          ),
        ],
      ),
      body: FutureBuilder<ScadaRecipe>(
        future: _recipe,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Reçete bulunamadı.'));
          } else {
            final recipe = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reçete Adı: ${recipe.name}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Makine Tipi: ${recipe.machineType}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Reçete Adımları',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: recipe.steps.length,
                      itemBuilder: (context, index) {
                        final step = recipe.steps[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text((index + 1).toString()),
                            ),
                            title: Text('Adım Tipi: ${step.stepType}'),
                            subtitle: Text(
                              'Parametreler: ${step.parameters.entries.map((e) => '${e.key}: ${e.value}').join(', ')}',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
