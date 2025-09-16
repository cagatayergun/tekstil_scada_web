import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/scada_recipe.dart';
import 'package:tekstil_scada_web/services/recipe_service.dart';

class WorkingStepEditor extends StatefulWidget {
  final ScadaRecipeStep step;
  final int recipeId;

  const WorkingStepEditor({
    Key? key,
    required this.step,
    required this.recipeId,
  }) : super(key: key);

  @override
  _WorkingStepEditorState createState() => _WorkingStepEditorState();
}

class _WorkingStepEditorState extends State<WorkingStepEditor> {
  late TextEditingController _durationController;
  final RecipeService _recipeService = RecipeService();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _durationController = TextEditingController(
      text: widget.step.parameters['duration']?.toString() ?? '0',
    );
  }

  @override
  void dispose() {
    _durationController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    setState(() {
      _isSaving = true;
    });
    final updatedStep = ScadaRecipeStep(
      stepId: widget.step.stepId,
      stepType: widget.step.stepType,
      parameters: {'duration': int.tryParse(_durationController.text) ?? 0},
    );
    try {
      await _recipeService.updateRecipeStep(widget.recipeId, updatedStep);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Çalışma adımı başarıyla güncellendi.')),
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
          decoration: const InputDecoration(
            labelText: 'Çalışma Süresi (dakika)',
          ),
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
