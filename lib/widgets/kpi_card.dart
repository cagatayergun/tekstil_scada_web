// Gerekli paketleri içe aktarın.
import 'package:flutter/material.dart';

// KpiCard widget'ı bir durumsuz (Stateless) widget'ı olarak tanımlanır.
// Çünkü bu widget'ın kendi içinde durumu değişmez, sadece aldığı verilere göre çizilir.
class KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const KpiCard({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6, // Hafif bir gölge efekti ekler.
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // KPI'ın başlığı.
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.8),
              ),
            ),

            // Boşluk ekler.
            const SizedBox(height: 8),

            // KPI'ın değeri.
            Text(
              value,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
