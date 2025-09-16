import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tekstil_scada_web/models/trend_data_point.dart';
import 'package:tekstil_scada_web/services/report_service.dart';
import 'package:tekstil_scada_web/widgets/select_machine_dialog.dart'; // Bu satırı ekleyin.
import 'package:tekstil_scada_web/models/machine.dart'; // Bu satırı ekleyin.

class TrendAnalysisPage extends StatefulWidget {
  const TrendAnalysisPage({Key? key}) : super(key: key);

  @override
  _TrendAnalysisPageState createState() => _TrendAnalysisPageState();
}

class _TrendAnalysisPageState extends State<TrendAnalysisPage> {
  Future<List<TrendDataPoint>>? _trendData;
  final ReportService _reportService = ReportService();
  Machine? _selectedMachine;

  // Başlangıçta makine seçimi yapmak için bir metot.
  void _selectMachineAndLoadData() async {
    final selectedMachine = await showDialog<Machine?>(
      context: context,
      builder: (context) => const SelectMachineDialog(),
    );
    if (selectedMachine != null) {
      setState(() {
        _selectedMachine = selectedMachine;
        // API'den trend verilerini çekme işlemi.
        _trendData = _reportService.getTrendData(selectedMachine.id.toString());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _selectMachineAndLoadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedMachine != null
              ? '${_selectedMachine!.name} Trend Analizi'
              : 'Trend Analiz Raporu',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _selectMachineAndLoadData,
            tooltip: 'Makineyi Değiştir',
          ),
        ],
      ),
      body: _trendData == null
          ? const Center(child: Text('Lütfen bir makine seçin.'))
          : FutureBuilder<List<TrendDataPoint>>(
              future: _trendData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Hata: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Veri bulunamadı.'));
                } else {
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
                            // ... (Grafik konfigürasyonu aynı kalacak)
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
