import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/machine.dart';
import 'package:tekstil_scada_web/services/machine_service.dart';

class SelectMachineDialog extends StatelessWidget {
  const SelectMachineDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MachineService machineService = MachineService();

    return AlertDialog(
      title: const Text('Makine Seçin'),
      content: SizedBox(
        width: double.maxFinite,
        child: FutureBuilder<List<Machine>>(
          future: machineService.getAllMachines(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Hata: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Makine bulunamadı.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final machine = snapshot.data![index];
                  return ListTile(
                    title: Text(machine.name),
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pop(machine); // Seçilen makineyi döndürür.
                    },
                  );
                },
              );
            }
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Diyaloğu kapatır.
          },
          child: const Text('İptal'),
        ),
      ],
    );
  }
}
