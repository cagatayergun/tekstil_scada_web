import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/scada_recipe.dart';
import 'package:tekstil_scada_web/services/recipe_service.dart';

class EmptyingStepEditor extends StatefulWidget {
  final ScadaRecipeStep step;
  final int recipeId;

  const EmptyingStepEditor({
    Key? key,
    required this.step,
    required this.recipeId,
  }) : super(key: key);

  @override
  _EmptyingStepEditorState createState() => _EmptyingStepEditorState();
}

class _EmptyingStepEditorState extends State<EmptyingStepEditor> {
  late TextEditingController _durationController;
  late String _emptyingType;
  final RecipeService _recipeService = RecipeService();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _durationController = TextEditingController(
      text: widget.step.parameters['duration']?.toString() ?? '0',
    );
    _emptyingType = widget.step.parameters['type']?.toString() ?? 'Tam';
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
      parameters: {
        'duration': int.tryParse(_durationController.text) ?? 0,
        'type': _emptyingType,
      },
    );
    try {
      await _recipeService.updateRecipeStep(widget.recipeId, updatedStep);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Boşaltma adımı başarıyla güncellendi.')),
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
        DropdownButtonFormField<String>(
          value: _emptyingType,
          items: ['Tam', 'Kısmi'].map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _emptyingType = newValue!;
            });
          },
          decoration: const InputDecoration(labelText: 'Boşaltma Tipi'),
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
