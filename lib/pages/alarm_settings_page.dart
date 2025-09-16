import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/alarm_definition.dart';
import 'package:tekstil_scada_web/services/settings_service.dart';

class AlarmSettingsPage extends StatefulWidget {
  const AlarmSettingsPage({Key? key}) : super(key: key);

  @override
  _AlarmSettingsPageState createState() => _AlarmSettingsPageState();
}

class _AlarmSettingsPageState extends State<AlarmSettingsPage> {
  late Future<List<AlarmDefinition>> _alarmDefinitions;
  final SettingsService _settingsService = SettingsService();

  @override
  void initState() {
    super.initState();
    _alarmDefinitions = _settingsService.getAlarmDefinitions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alarm Ayarları')),
      body: FutureBuilder<List<AlarmDefinition>>(
        future: _alarmDefinitions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Alarm tanımı bulunamadı.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final alarm = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.warning, color: Colors.red),
                    title: Text('${alarm.machineName} - ${alarm.description}'),
                    subtitle: Text(
                      'Eşik Değeri: ${alarm.threshold} | Öncelik: ${alarm.priority}',
                    ),
                    onTap: () {
                      // Düzenleme formu açılabilir
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
