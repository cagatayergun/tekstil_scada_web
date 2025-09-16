import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/scada_recipe.dart';

class WaterIntakeStepEditor extends StatefulWidget {
  final ScadaRecipeStep step;

  const WaterIntakeStepEditor({Key? key, required this.step}) : super(key: key);

  @override
  _WaterIntakeStepEditorState createState() => _WaterIntakeStepEditorState();
}

class _WaterIntakeStepEditorState extends State<WaterIntakeStepEditor> {
  late TextEditingController _volumeController;
  late TextEditingController _temperatureController;

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
        ElevatedButton(
          onPressed: () {
            // API'ye kaydetme mantığı buraya gelecek.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Su Alma adımı kaydedildi.')),
            );
          },
          child: const Text('Kaydet'),
        ),
      ],
    );
  }
}
