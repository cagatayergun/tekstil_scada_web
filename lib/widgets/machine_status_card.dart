import 'package:flutter/material.dart';
import '../models/machine_status.dart';

class MachineStatusCard extends StatelessWidget {
  final MachineStatus machineStatus;

  const MachineStatusCard({Key? key, required this.machineStatus})
    : super(key: key);

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'çalışıyor':
        return Colors.green;
      case 'duruş':
        return Colors.orange;
      case 'arıza':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Makine Adı ve Durumu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  machineStatus.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(machineStatus.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    machineStatus.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Makine Görseli
            Center(
              child: Image.network(
                machineStatus.imageUrl,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 100),
              ),
            ),
            const SizedBox(height: 12),

            // Sıcaklık ve RPM Bilgileri
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoColumn(
                  Icons.thermostat,
                  'Sıcaklık',
                  '${machineStatus.temperature}°C',
                  Colors.orange,
                ),
                _buildInfoColumn(
                  Icons.speed,
                  'Hız',
                  '${machineStatus.rpm} rpm',
                  Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
