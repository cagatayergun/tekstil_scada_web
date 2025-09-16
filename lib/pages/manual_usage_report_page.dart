import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/manual_usage_report_item.dart';
import 'package:tekstil_scada_web/services/report_service.dart';
import 'package:intl/intl.dart'; // Tarih formatlama için intl paketini ekleyin.

class ManualUsageReportPage extends StatefulWidget {
  const ManualUsageReportPage({Key? key}) : super(key: key);

  @override
  _ManualUsageReportPageState createState() => _ManualUsageReportPageState();
}

class _ManualUsageReportPageState extends State<ManualUsageReportPage> {
  late Future<List<ManualUsageReportItem>> _manualUsageData;
  final ReportService _reportService = ReportService();

  @override
  void initState() {
    super.initState();
    _manualUsageData = _reportService.getManualUsageReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manuel Kullanım Raporu')),
      body: FutureBuilder<List<ManualUsageReportItem>>(
        future: _manualUsageData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Manuel kullanım verisi bulunamadı.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.handyman, color: Colors.brown),
                    title: Text('${item.materialName} - ${item.machineName}'),
                    subtitle: Text(
                      'Miktar: ${item.quantity} ${item.unit}\nKullanıcı: ${item.userName}\nTarih: ${DateFormat('dd/MM/yyyy').format(item.date)}',
                    ),
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
