import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/scada_recipe.dart';

class WorkingStepEditor extends StatefulWidget {
  final ScadaRecipeStep step;

  const WorkingStepEditor({Key? key, required this.step}) : super(key: key);

  @override
  _WorkingStepEditorState createState() => _WorkingStepEditorState();
}

class _WorkingStepEditorState extends State<WorkingStepEditor> {
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
            labelText: 'Çalışma Süresi (dakika)',
          ),
          keyboardType: TextInputType.number,
        ),
        ElevatedButton(
          onPressed: () {
            // API'ye kaydetme mantığı buraya gelecek.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Çalışma adımı kaydedildi.')),
            );
          },
          child: const Text('Kaydet'),
        ),
      ],
    );
  }
}
