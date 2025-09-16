import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tekstil_scada_web/models/trend_data_point.dart';
import 'package:tekstil_scada_web/services/report_service.dart';

class TrendAnalysisPage extends StatefulWidget {
  const TrendAnalysisPage({Key? key}) : super(key: key);

  @override
  _TrendAnalysisPageState createState() => _TrendAnalysisPageState();
}

class _TrendAnalysisPageState extends State<TrendAnalysisPage> {
  late Future<List<TrendDataPoint>> _trendData;
  final ReportService _reportService = ReportService();

  // Bu örnekte sıcaklık verisini çekeceğiz.
  final String _parameter = 'temperature';

  @override
  void initState() {
    super.initState();
    _trendData = _reportService.getTrendData(_parameter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trend Analiz Raporu')),
      body: FutureBuilder<List<TrendDataPoint>>(
        future: _trendData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Trend verisi bulunamadı.'));
          } else {
            // Veri başarıyla yüklendi, grafiği çizelim.
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: snapshot.data!.map((point) {
                            return FlSpot(
                              point.timestamp.millisecondsSinceEpoch.toDouble(),
                              point.value,
                            );
                          }).toList(),
                          isCurved: true,
                          color: Colors.blue,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                        ),
                      ],
                      // Eksende başlıkları ve verileri gösterelim.
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              final timestamp =
                                  DateTime.fromMillisecondsSinceEpoch(
                                    value.toInt(),
                                  );
                              final formattedTime =
                                  '${timestamp.hour}:${timestamp.minute}';
                              return Text(
                                formattedTime,
                                style: const TextStyle(fontSize: 10),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                '${value.toStringAsFixed(0)}°C',
                                style: const TextStyle(fontSize: 10),
                              );
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                          color: const Color(0xff37434d),
                          width: 1,
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 10,
                        checkToShowHorizontalLine: (value) => value % 10 == 0,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
