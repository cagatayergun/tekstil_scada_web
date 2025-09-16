import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/kpi_view_model.dart';
import 'package:tekstil_scada_web/services/api_service.dart';
import 'package:tekstil_scada_web/widgets/kpi_card.dart'; // Daha önceki adımda oluşturduğumuz widget.

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<List<KpiViewModel>> _kpiData;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _kpiData = _apiService.getDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Genel Bakış')),
      body: FutureBuilder<List<KpiViewModel>>(
        future: _kpiData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Veri bulunamadı.'));
          } else {
            // Veri başarıyla yüklendi, KPI kartlarını göster.
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Her satırda 2 kart.
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final kpi = snapshot.data![index];
                  return KpiCard(
                    title: kpi.title,
                    value: kpi.value,
                    color: index % 2 == 0
                        ? Colors.blue
                        : Colors.green, // Örnek renkler.
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
