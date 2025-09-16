import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/scada_recipe.dart';
import 'package:tekstil_scada_web/services/recipe_service.dart';

class SpinningStepEditor extends StatefulWidget {
  final ScadaRecipeStep step;
  final int recipeId;

  const SpinningStepEditor({
    Key? key,
    required this.step,
    required this.recipeId,
  }) : super(key: key);

  @override
  _SpinningStepEditorState createState() => _SpinningStepEditorState();
}

class _SpinningStepEditorState extends State<SpinningStepEditor> {
  late TextEditingController _durationController;
  late TextEditingController _speedController;
  final RecipeService _recipeService = RecipeService();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _durationController = TextEditingController(
      text: widget.step.parameters['duration']?.toString() ?? '0',
    );
    _speedController = TextEditingController(
      text: widget.step.parameters['speed']?.toString() ?? '0',
    );
  }

  @override
  void dispose() {
    _durationController.dispose();
    _speedController.dispose();
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
        'duration': int.tryParse(_durationController.text) ?? 0,
        'speed': int.tryParse(_speedController.text) ?? 0,
      },
    );
    try {
      await _recipeService.updateRecipeStep(widget.recipeId, updatedStep);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sıkma adımı başarıyla güncellendi.')),
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
          controller: _durationController,
          decoration: const InputDecoration(labelText: 'Süre (dakika)'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: _speedController,
          decoration: const InputDecoration(labelText: 'Hız (RPM)'),
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
