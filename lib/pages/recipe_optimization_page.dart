import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/recipe_optimization_data.dart';
import 'package:tekstil_scada_web/services/report_service.dart';

class RecipeOptimizationPage extends StatefulWidget {
  const RecipeOptimizationPage({Key? key}) : super(key: key);

  @override
  _RecipeOptimizationPageState createState() => _RecipeOptimizationPageState();
}

class _RecipeOptimizationPageState extends State<RecipeOptimizationPage> {
  late Future<List<RecipeOptimizationData>> _optimizationData;
  final ReportService _reportService = ReportService();

  @override
  void initState() {
    super.initState();
    _optimizationData = _reportService.getRecipeOptimizationReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reçete Optimizasyonu')),
      body: FutureBuilder<List<RecipeOptimizationData>>(
        future: _optimizationData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Reçete optimizasyon verisi bulunamadı.'),
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
                    leading: const Icon(Icons.psychology, color: Colors.indigo),
                    title: Text(item.recipeName),
                    subtitle: Text(
                      'Mevcut Maliyet: ${item.currentCost.toStringAsFixed(2)} TL\n'
                      'Optimize Edilmiş Maliyet: ${item.optimizedCost.toStringAsFixed(2)} TL\n'
                      'Tasarruf: ${item.savings}',
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
