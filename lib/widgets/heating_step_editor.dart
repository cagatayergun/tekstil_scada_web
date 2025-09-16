import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/scada_recipe.dart';

class HeatingStepEditor extends StatefulWidget {
  final ScadaRecipeStep step;

  const HeatingStepEditor({Key? key, required this.step}) : super(key: key);

  @override
  _HeatingStepEditorState createState() => _HeatingStepEditorState();
}

class _HeatingStepEditorState extends State<HeatingStepEditor> {
  late TextEditingController _temperatureController;
  late TextEditingController _durationController;

  @override
  void initState() {
    super.initState();
    // API'den gelen veriyi controller'lara atayın.
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
        // Değişiklikleri kaydetmek için buton
        ElevatedButton(
          onPressed: () {
            // API'ye POST veya PUT isteği gönderme mantığı buraya gelecek.
            // Örnek: _saveChanges(widget.step.stepId, _temperatureController.text, _durationController.text);
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
