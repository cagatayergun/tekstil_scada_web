import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/machine_settings.dart';
import 'package:tekstil_scada_web/services/settings_service.dart';

class MachineSettingsPage extends StatefulWidget {
  const MachineSettingsPage({Key? key}) : super(key: key);

  @override
  _MachineSettingsPageState createState() => _MachineSettingsPageState();
}

class _MachineSettingsPageState extends State<MachineSettingsPage> {
  late Future<List<MachineSettings>> _machineSettings;
  final SettingsService _settingsService = SettingsService();

  @override
  void initState() {
    super.initState();
    _machineSettings = _settingsService.getMachineSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Makine Ayarları')),
      body: FutureBuilder<List<MachineSettings>>(
        future: _machineSettings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Makine ayarı bulunamadı.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final settings = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text(settings.machineName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('IP Adresi: ${settings.ipAddress}'),
                        Text('PLC Tipi: ${settings.plcType}'),
                      ],
                    ),
                    trailing: const Icon(Icons.edit),
                    onTap: () {
                      // Düzenleme sayfasına yönlendirme yapılacak
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
