// lib/pages/recipe_step_designer_page.dart dosyasını güncelleyin.
import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/scada_recipe.dart';
import 'package:tekstil_scada_web/services/recipe_service.dart';
import 'package:tekstil_scada_web/widgets/heating_step_editor.dart';
import 'package:tekstil_scada_web/widgets/drying_step_editor.dart';
import 'package:tekstil_scada_web/widgets/water_intake_step_editor.dart';
import 'package:tekstil_scada_web/widgets/spinning_step_editor.dart';
import 'package:tekstil_scada_web/widgets/dosing_step_editor.dart';
import 'package:tekstil_scada_web/widgets/emptying_step_editor.dart';
import 'package:tekstil_scada_web/widgets/working_step_editor.dart'; // Bu satırı ekleyin.

class RecipeStepDesignerPage extends StatefulWidget {
  final int recipeId;

  const RecipeStepDesignerPage({Key? key, required this.recipeId})
    : super(key: key);

  @override
  _RecipeStepDesignerPageState createState() => _RecipeStepDesignerPageState();
}

class _RecipeStepDesignerPageState extends State<RecipeStepDesignerPage> {
  late Future<ScadaRecipe> _recipe;
  final RecipeService _recipeService = RecipeService();

  @override
  void initState() {
    super.initState();
    _recipe = _recipeService.getRecipeById(widget.recipeId);
  }

  Widget _getStepEditorWidget(ScadaRecipeStep step) {
    switch (step.stepType.toLowerCase()) {
      case 'ısıtma':
        return HeatingStepEditor(step: step);
      case 'kurutma':
        return DryingStepEditor(step: step);
      case 'su_alma':
        return WaterIntakeStepEditor(step: step);
      case 'sıkma':
        return SpinningStepEditor(step: step);
      case 'dozaj':
        return DosingStepEditor(step: step);
      case 'boşaltma':
        return EmptyingStepEditor(step: step);
      case 'çalışma': // Yeni eklenen adım tipi
        return WorkingStepEditor(step: step);
      default:
        return Text('Bilinmeyen adım tipi: ${step.stepType}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reçete Adımlarını Düzenle')),
      body: FutureBuilder<ScadaRecipe>(
        future: _recipe,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Reçete adımı bulunamadı.'));
          } else {
            final recipe = snapshot.data!;
            return ListView.builder(
              itemCount: recipe.steps.length,
              itemBuilder: (context, index) {
                final step = recipe.steps[index];
                return ExpansionTile(
                  title: Text('${index + 1}. Adım: ${step.stepType}'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _getStepEditorWidget(step),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
