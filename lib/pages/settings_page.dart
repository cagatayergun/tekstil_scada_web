// lib/pages/settings_page.dart dosyasını güncelleyin.
import 'package:flutter/material.dart';
import 'user_settings_page.dart';
import 'machine_settings_page.dart';
import 'cost_settings_page.dart';
import 'alarm_settings_page.dart';
import 'plc_operator_settings_page.dart'; // Bu satırı ekleyin.

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayarlar')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blue),
            title: const Text('Kullanıcı Ayarları'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UserSettingsPage(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.precision_manufacturing,
              color: Colors.green,
            ),
            title: const Text('Makine Ayarları'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MachineSettingsPage(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.attach_money, color: Colors.orange),
            title: const Text('Maliyet Ayarları'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CostSettingsPage(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications_active, color: Colors.red),
            title: const Text('Alarm Ayarları'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AlarmSettingsPage(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.engineering, color: Colors.indigo),
            title: const Text('PLC Operatör Ayarları'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      const PlcOperatorSettingsPage(), // Bu satırı güncelleyin.
                ),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
