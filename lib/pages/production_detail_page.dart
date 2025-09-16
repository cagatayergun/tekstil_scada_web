import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/production_detail.dart';
import 'package:tekstil_scada_web/services/report_service.dart';
import 'package:intl/intl.dart';

class ProductionDetailPage extends StatefulWidget {
  const ProductionDetailPage({Key? key}) : super(key: key);

  @override
  _ProductionDetailPageState createState() => _ProductionDetailPageState();
}

class _ProductionDetailPageState extends State<ProductionDetailPage> {
  late Future<List<ProductionDetail>> _productionDetailData;
  final ReportService _reportService = ReportService();

  @override
  void initState() {
    super.initState();
    _productionDetailData = _reportService.getProductionDetailReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Üretim Detayları')),
      body: FutureBuilder<List<ProductionDetail>>(
        future: _productionDetailData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Üretim detayı verisi bulunamadı.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                final duration = item.endTime?.difference(item.startTime);
                final formattedDuration = duration != null
                    ? '${duration.inHours}sa ${duration.inMinutes.remainder(60)}dk'
                    : 'Devam Ediyor';
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.inventory, color: Colors.blue),
                    title: Text('${item.productName} - ${item.machineName}'),
                    subtitle: Text(
                      'Durum: ${item.status}\nMiktar: ${item.producedQuantity}\nSüre: $formattedDuration',
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
