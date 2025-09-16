import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/scada_recipe.dart';
import 'package:tekstil_scada_web/services/recipe_service.dart';

class WaterIntakeStepEditor extends StatefulWidget {
  final ScadaRecipeStep step;
  final int recipeId;

  const WaterIntakeStepEditor({
    Key? key,
    required this.step,
    required this.recipeId,
  }) : super(key: key);

  @override
  _WaterIntakeStepEditorState createState() => _WaterIntakeStepEditorState();
}

class _WaterIntakeStepEditorState extends State<WaterIntakeStepEditor> {
  late TextEditingController _volumeController;
  late TextEditingController _temperatureController;
  final RecipeService _recipeService = RecipeService();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _volumeController = TextEditingController(
      text: widget.step.parameters['volume']?.toString() ?? '0',
    );
    _temperatureController = TextEditingController(
      text: widget.step.parameters['temperature']?.toString() ?? '0',
    );
  }

  @override
  void dispose() {
    _volumeController.dispose();
    _temperatureController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    setState(() {
      _isSaving = true;
    });
    final updatedStep = ScadaRecipeStep(
      stepId: widget.step.stepId,
      stepType: widget.step.stepType,
      parameters: {
        'volume': double.tryParse(_volumeController.text) ?? 0.0,
        'temperature': double.tryParse(_temperatureController.text) ?? 0.0,
      },
    );
    try {
      await _recipeService.updateRecipeStep(widget.recipeId, updatedStep);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Su Alma adımı başarıyla güncellendi.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Hata: ${e.toString()}')));
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _volumeController,
          decoration: const InputDecoration(labelText: 'Su Miktarı (Litre)'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: _temperatureController,
          decoration: const InputDecoration(labelText: 'Sıcaklık (°C)'),
          keyboardType: TextInputType.number,
        ),
        _isSaving
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _saveChanges,
                child: const Text('Kaydet'),
              ),
      ],
    );
  }
}
