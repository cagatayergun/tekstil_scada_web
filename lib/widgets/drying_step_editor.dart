import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/scada_recipe.dart';

class DryingStepEditor extends StatefulWidget {
  final ScadaRecipeStep step;

  const DryingStepEditor({Key? key, required this.step}) : super(key: key);

  @override
  _DryingStepEditorState createState() => _DryingStepEditorState();
}

class _DryingStepEditorState extends State<DryingStepEditor> {
  late TextEditingController _durationController;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _durationController,
          decoration: const InputDecoration(
            labelText: 'Kurutma Süresi (dakika)',
          ),
          keyboardType: TextInputType.number,
        ),
        // Değişiklikleri kaydetmek için buton
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Değişiklikler kaydedildi.')),
            );
          },
          child: const Text('Kaydet'),
        ),
      ],
    );
  }
}
