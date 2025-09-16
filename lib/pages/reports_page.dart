import 'package:flutter/material.dart';
import 'alarm_report_page.dart'; // Bir sonraki adımda oluşturacağız.

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Raporlar')),
      body: ListView(
        children: [
          // Alarm Raporu sayfası için bir liste elemanı.
          ListTile(
            leading: const Icon(Icons.warning, color: Colors.orange),
            title: const Text('Alarm Raporu'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AlarmReportPage(),
                ),
              );
            },
          ),
          const Divider(),

          // Buraya diğer rapor türleri için Listeleme elemanları eklenebilir.
          // ListTile(
          //   leading: const Icon(Icons.trending_up, color: Colors.green),
          //   title: const Text('Trend Analiz Raporu'),
          //   trailing: const Icon(Icons.chevron_right),
          //   onTap: () {
          //     // Trend Analiz Sayfasına yönlendirme yapılacak.
          //   },
          // ),
          // const Divider(),
        ],
      ),
    );
  }
}
