import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/scada_recipe.dart';
import 'package:tekstil_scada_web/services/recipe_service.dart';

class DosingStepEditor extends StatefulWidget {
  final ScadaRecipeStep step;
  final int recipeId;

  const DosingStepEditor({Key? key, required this.step, required this.recipeId})
    : super(key: key);

  @override
  _DosingStepEditorState createState() => _DosingStepEditorState();
}

class _DosingStepEditorState extends State<DosingStepEditor> {
  late TextEditingController _materialController;
  late TextEditingController _quantityController;
  final RecipeService _recipeService = RecipeService();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _materialController = TextEditingController(
      text: widget.step.parameters['material']?.toString() ?? '',
    );
    _quantityController = TextEditingController(
      text: widget.step.parameters['quantity']?.toString() ?? '0',
    );
  }

  @override
  void dispose() {
    _materialController.dispose();
    _quantityController.dispose();
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
        'material': _materialController.text,
        'quantity': double.tryParse(_quantityController.text) ?? 0.0,
      },
    );
    try {
      await _recipeService.updateRecipeStep(widget.recipeId, updatedStep);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dozaj adımı başarıyla güncellendi.')),
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
          controller: _materialController,
          decoration: const InputDecoration(labelText: 'Dozaj Malzemesi'),
        ),
        TextField(
          controller: _quantityController,
          decoration: const InputDecoration(labelText: 'Miktar (kg/L)'),
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
