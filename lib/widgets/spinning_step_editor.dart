import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/scada_recipe.dart';

class SpinningStepEditor extends StatefulWidget {
  final ScadaRecipeStep step;

  const SpinningStepEditor({Key? key, required this.step}) : super(key: key);

  @override
  _SpinningStepEditorState createState() => _SpinningStepEditorState();
}

class _SpinningStepEditorState extends State<SpinningStepEditor> {
  late TextEditingController _durationController;
  late TextEditingController _speedController;

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
        ElevatedButton(
          onPressed: () {
            // API'ye kaydetme mantığı buraya gelecek.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sıkma adımı kaydedildi.')),
            );
          },
          child: const Text('Kaydet'),
        ),
      ],
    );
  }
}
