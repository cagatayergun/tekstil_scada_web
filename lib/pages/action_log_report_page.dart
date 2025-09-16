import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/action_log_entry.dart';
import 'package:tekstil_scada_web/services/report_service.dart';
import 'package:intl/intl.dart'; // Tarih formatlama için intl paketini ekleyin.

class ActionLogReportPage extends StatefulWidget {
  const ActionLogReportPage({Key? key}) : super(key: key);

  @override
  _ActionLogReportPageState createState() => _ActionLogReportPageState();
}

class _ActionLogReportPageState extends State<ActionLogReportPage> {
  late Future<List<ActionLogEntry>> _actionLogData;
  final ReportService _reportService = ReportService();

  @override
  void initState() {
    super.initState();
    _actionLogData = _reportService.getActionLogReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Eylem Kaydı Raporu')),
      body: FutureBuilder<List<ActionLogEntry>>(
        future: _actionLogData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Eylem kaydı verisi bulunamadı.'));
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
                    leading: const Icon(Icons.history, color: Colors.brown),
                    title: Text('${item.action} - ${item.machineName}'),
                    subtitle: Text(
                      'Kullanıcı: ${item.userName}\nTarih: ${DateFormat('dd/MM/yyyy HH:mm').format(item.timestamp)}',
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
