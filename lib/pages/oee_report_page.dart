// lib/pages/oee_report_page.dart dosyasını güncelleyin.
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tekstil_scada_web/models/oee_data.dart';
import 'package:tekstil_scada_web/services/report_service.dart';

class OeeReportPage extends StatefulWidget {
  const OeeReportPage({Key? key}) : super(key: key);

  @override
  _OeeReportPageState createState() => _OeeReportPageState();
}

class _OeeReportPageState extends State<OeeReportPage> {
  late Future<OeeData> _oeeData;
  final ReportService _reportService = ReportService();

  @override
  void initState() {
    super.initState();
    _oeeData = _reportService.getOeeReportData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OEE Raporu')),
      body: FutureBuilder<OeeData>(
        future: _oeeData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('OEE verisi bulunamadı.'));
          } else {
            final oee = snapshot.data!;
            final total = oee.availability + oee.performance + oee.quality;

            final pieChartSections = [
              PieChartSectionData(
                color: Colors.blue,
                value: oee.availability,
                title: '${oee.availability.toStringAsFixed(1)}%',
                radius: 50,
              ),
              PieChartSectionData(
                color: Colors.green,
                value: oee.performance,
                title: '${oee.performance.toStringAsFixed(1)}%',
                radius: 50,
              ),
              PieChartSectionData(
                color: Colors.orange,
                value: oee.quality,
                title: '${oee.quality.toStringAsFixed(1)}%',
                radius: 50,
              ),
            ];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Text(
                            'Genel OEE: ${oee.oee.toStringAsFixed(1)}%',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ), // Bu satır güncellendi.
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 200,
                            child: PieChart(
                              PieChartData(
                                sections: pieChartSections,
                                centerSpaceRadius: 40,
                                sectionsSpace: 4,
                                pieTouchData: PieTouchData(enabled: true),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          _buildLegend(
                            'Kullanılabilirlik: ${oee.availability.toStringAsFixed(1)}%',
                            Colors.blue,
                          ),
                          _buildLegend(
                            'Performans: ${oee.performance.toStringAsFixed(1)}%',
                            Colors.green,
                          ),
                          _buildLegend(
                            'Kalite: ${oee.quality.toStringAsFixed(1)}%',
                            Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildLegend(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 16, height: 16, color: color),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
