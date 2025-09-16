import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/plc_operator.dart';
import 'package:tekstil_scada_web/services/settings_service.dart';

class PlcOperatorSettingsPage extends StatefulWidget {
  const PlcOperatorSettingsPage({Key? key}) : super(key: key);

  @override
  _PlcOperatorSettingsPageState createState() =>
      _PlcOperatorSettingsPageState();
}

class _PlcOperatorSettingsPageState extends State<PlcOperatorSettingsPage> {
  late Future<List<PlcOperator>> _plcOperators;
  final SettingsService _settingsService = SettingsService();

  @override
  void initState() {
    super.initState();
    _plcOperators = _settingsService.getPlcOperators();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PLC Operatör Ayarları')),
      body: FutureBuilder<List<PlcOperator>>(
        future: _plcOperators,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('PLC operatör verisi bulunamadı.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final operator = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.person_pin,
                      color: Colors.blueAccent,
                    ),
                    title: Text(operator.name),
                    subtitle: Text('Erişim Seviyesi: ${operator.level}'),
                    trailing: const Icon(Icons.edit),
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
