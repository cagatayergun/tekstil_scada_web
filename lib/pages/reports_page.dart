// lib/pages/reports_page.dart dosyasını güncelleyin.
import 'package:flutter/material.dart';
import 'alarm_report_page.dart';
import 'trend_analysis_page.dart';
import 'oee_report_page.dart';
import 'production_report_page.dart';
import 'action_log_report_page.dart';
import 'manual_usage_report_page.dart';
import 'recipe_optimization_page.dart';
import 'production_detail_page.dart'; // Bu satırı ekleyin.

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Raporlar')),
      body: ListView(
        children: [
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
          ListTile(
            leading: const Icon(Icons.trending_up, color: Colors.green),
            title: const Text('Trend Analiz Raporu'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TrendAnalysisPage(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.insights, color: Colors.blue),
            title: const Text('OEE Raporu'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const OeeReportPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.factory, color: Colors.purple),
            title: const Text('Üretim Raporu'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProductionReportPage(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.list_alt,
              color: Colors.deepPurple,
            ), // Yeni eklenen
            title: const Text('Üretim Detayları'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      const ProductionDetailPage(), // Bu satırı güncelleyin.
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.history, color: Colors.brown),
            title: const Text('Eylem Kaydı Raporu'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ActionLogReportPage(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.handyman, color: Colors.brown),
            title: const Text('Manuel Kullanım Raporu'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ManualUsageReportPage(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.psychology, color: Colors.indigo),
            title: const Text('Reçete Optimizasyonu'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const RecipeOptimizationPage(),
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
