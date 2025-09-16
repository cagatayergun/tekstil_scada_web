import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/scada_recipe.dart';

class DosingStepEditor extends StatefulWidget {
  final ScadaRecipeStep step;

  const DosingStepEditor({Key? key, required this.step}) : super(key: key);

  @override
  _DosingStepEditorState createState() => _DosingStepEditorState();
}

class _DosingStepEditorState extends State<DosingStepEditor> {
  late TextEditingController _materialController;
  late TextEditingController _quantityController;

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
        ElevatedButton(
          onPressed: () {
            // API'ye kaydetme mantığı buraya gelecek.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Dozaj adımı kaydedildi.')),
            );
          },
          child: const Text('Kaydet'),
        ),
      ],
    );
  }
}
