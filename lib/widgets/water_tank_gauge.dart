import 'package:flutter/material.dart';

class WaterTankGauge extends StatelessWidget {
  final double fillPercentage; // Doluluk yüzdesi (0.0 - 1.0 arası).
  final double height;
  final double width;

  const WaterTankGauge({
    Key? key,
    required this.fillPercentage,
    this.height = 200,
    this.width = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // Doluluk seviyesini gösteren container.
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: height * fillPercentage,
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
          ),
          // Yüzde bilgisini gösteren metin.
          Center(
            child: Text(
              '${(fillPercentage * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
