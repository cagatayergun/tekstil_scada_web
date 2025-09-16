// lib/widgets/heating_step_editor.dart dosyasını güncelleyin.
import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/scada_recipe.dart';
import 'package:tekstil_scada_web/services/recipe_service.dart';

class HeatingStepEditor extends StatefulWidget {
  final ScadaRecipeStep step;
  final int recipeId; // Reçete ID'sini almak için ekledik.

  const HeatingStepEditor({
    Key? key,
    required this.step,
    required this.recipeId,
  }) : super(key: key);

  @override
  _HeatingStepEditorState createState() => _HeatingStepEditorState();
}

class _HeatingStepEditorState extends State<HeatingStepEditor> {
  late TextEditingController _temperatureController;
  late TextEditingController _durationController;
  final RecipeService _recipeService = RecipeService();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _temperatureController = TextEditingController(
      text: widget.step.parameters['temperature']?.toString() ?? '0',
    );
    _durationController = TextEditingController(
      text: widget.step.parameters['duration']?.toString() ?? '0',
    );
  }

  @override
  void dispose() {
    _temperatureController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  // Kaydetme işlemi için yeni metot
  Future<void> _saveChanges() async {
    setState(() {
      _isSaving = true;
    });

    final updatedStep = ScadaRecipeStep(
      stepId: widget.step.stepId,
      stepType: widget.step.stepType,
      parameters: {
        'temperature': double.tryParse(_temperatureController.text) ?? 0.0,
        'duration': int.tryParse(_durationController.text) ?? 0,
      },
    );

    try {
      await _recipeService.updateRecipeStep(widget.recipeId, updatedStep);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Isıtma adımı başarıyla güncellendi.')),
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
          controller: _temperatureController,
          decoration: const InputDecoration(labelText: 'Sıcaklık (°C)'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: _durationController,
          decoration: const InputDecoration(labelText: 'Süre (dakika)'),
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
