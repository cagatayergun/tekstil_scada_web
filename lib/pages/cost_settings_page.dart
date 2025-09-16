// Gerekli import ifadelerini kontrol edin ve eksik olanı ekleyin.
import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/cost_parameter.dart'; // Bu satırı ekleyin
import 'package:tekstil_scada_web/services/settings_service.dart';

class CostSettingsPage extends StatefulWidget {
  const CostSettingsPage({Key? key}) : super(key: key);

  @override
  _CostSettingsPageState createState() => _CostSettingsPageState();
}

class _CostSettingsPageState extends State<CostSettingsPage> {
  late Future<List<CostParameter>> _costParameters;
  final SettingsService _settingsService = SettingsService();

  @override
  void initState() {
    super.initState();
    _costParameters = _settingsService.getCostParameters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Maliyet Ayarları')),
      body: FutureBuilder<List<CostParameter>>(
        future: _costParameters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Maliyet verisi bulunamadı.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final parameter = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.currency_lira),
                    title: Text(parameter.name),
                    trailing: Text(
                      '${parameter.value.toStringAsFixed(2)} ${parameter.unit}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
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
