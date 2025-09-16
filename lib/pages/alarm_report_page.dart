import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/alarm_report_item.dart';
import 'package:tekstil_scada_web/services/report_service.dart';

class AlarmReportPage extends StatefulWidget {
  const AlarmReportPage({Key? key}) : super(key: key);

  @override
  _AlarmReportPageState createState() => _AlarmReportPageState();
}

class _AlarmReportPageState extends State<AlarmReportPage> {
  late Future<List<AlarmReportItem>> _alarmReportData;
  final ReportService _reportService = ReportService();

  @override
  void initState() {
    super.initState();
    _alarmReportData = _reportService.getAlarmReportData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alarm Raporu')),
      body: FutureBuilder<List<AlarmReportItem>>(
        future: _alarmReportData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Alarm verisi bulunamadı.'));
          } else {
            // Veri başarıyla yüklendi, bir liste olarak gösterelim.
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final alarm = snapshot.data![index];
                return ListTile(
                  leading: const Icon(Icons.error, color: Colors.red),
                  title: Text(alarm.machineName),
                  subtitle: Text(alarm.alarmDescription),
                  trailing: Text(
                    '${alarm.durationInMinutes.toStringAsFixed(1)} dk',
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
