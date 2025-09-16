import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/pages/dashboard_page.dart';
import 'package:tekstil_scada_web/pages/process_monitoring_page.dart';
import 'package:tekstil_scada_web/pages/reports_page.dart';
import 'package:tekstil_scada_web/pages/settings_page.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Menü başlığı
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Tekstil SCADA',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          // Genel Bakış sayfasına yönlendiren eleman
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Genel Bakış'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const DashboardPage()),
              );
            },
          ),
          // Proses İzleme sayfasına yönlendiren eleman
          ListTile(
            leading: const Icon(Icons.monitor),
            title: const Text('Proses İzleme'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const ProcessMonitoringPage(),
                ),
              );
            },
          ),
          // Raporlar sayfasına yönlendiren eleman
          ListTile(
            leading: const Icon(Icons.analytics),
            title: const Text('Raporlar'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const ReportsPage()),
              );
            },
          ),
          // Ayarlar sayfasına yönlendiren eleman
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Ayarlar'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          const Divider(),
          // Çıkış yapma butonu
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Çıkış Yap'),
            onTap: () {
              // Oturumu kapatma mantığı buraya gelecek.
              // Örneğin: Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage()));
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Çıkış yapıldı.')));
            },
          ),
        ],
      ),
    );
  }
}
