import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/production_report_item.dart';
import 'package:tekstil_scada_web/services/report_service.dart';
import 'package:intl/intl.dart'; // Tarih formatlama için intl paketini ekleyin.

class ProductionReportPage extends StatefulWidget {
  const ProductionReportPage({Key? key}) : super(key: key);

  @override
  _ProductionReportPageState createState() => _ProductionReportPageState();
}

class _ProductionReportPageState extends State<ProductionReportPage> {
  late Future<List<ProductionReportItem>> _productionReportData;
  final ReportService _reportService = ReportService();

  @override
  void initState() {
    super.initState();
    _productionReportData = _reportService.getProductionReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Üretim Raporu')),
      body: FutureBuilder<List<ProductionReportItem>>(
        future: _productionReportData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Üretim verisi bulunamadı.'));
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
                    leading: const Icon(Icons.inventory, color: Colors.blue),
                    title: Text('${item.productName} - ${item.machineName}'),
                    subtitle: Text(
                      'Tarih: ${DateFormat('dd/MM/yyyy').format(item.date)}\nMiktar: ${item.quantity} ${item.unit}',
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
