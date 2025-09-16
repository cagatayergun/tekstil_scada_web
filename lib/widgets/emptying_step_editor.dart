import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/scada_recipe.dart';

class EmptyingStepEditor extends StatefulWidget {
  final ScadaRecipeStep step;

  const EmptyingStepEditor({Key? key, required this.step}) : super(key: key);

  @override
  _EmptyingStepEditorState createState() => _EmptyingStepEditorState();
}

class _EmptyingStepEditorState extends State<EmptyingStepEditor> {
  late TextEditingController _durationController;
  late String _emptyingType;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _durationController,
          decoration: const InputDecoration(labelText: 'Süre (dakika)'),
          keyboardType: TextInputType.number,
        ),
        // Boşaltma tipini seçmek için bir dropdown menüsü eklenebilir.
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
        ElevatedButton(
          onPressed: () {
            // API'ye kaydetme mantığı buraya gelecek.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Boşaltma adımı kaydedildi.')),
            );
          },
          child: const Text('Kaydet'),
        ),
      ],
    );
  }
}
