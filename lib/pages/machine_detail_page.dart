import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/full_machine_status.dart';
import 'package:tekstil_scada_web/services/machine_service.dart';
import 'package:tekstil_scada_web/pages/process_control_page.dart';
import 'package:tekstil_scada_web/widgets/water_tank_gauge.dart'; // Bu satırı ekleyin.
import 'vnc_viewer_page.dart'; // Bu satırı ekleyin.

class MachineDetailPage extends StatefulWidget {
  final int machineId;

  const MachineDetailPage({Key? key, required this.machineId})
    : super(key: key);

  @override
  _MachineDetailPageState createState() => _MachineDetailPageState();
}

class _MachineDetailPageState extends State<MachineDetailPage> {
  late Future<FullMachineStatus> _machineDetail;
  final MachineService _machineService = MachineService();

  @override
  void initState() {
    super.initState();
    _machineDetail = _machineService.getMachineDetail(widget.machineId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Makine Detay'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_remote),
            onPressed: () {
              _machineDetail
                  .then((machine) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProcessControlPage(
                          machineId: machine.id,
                          machineName: machine.name,
                        ),
                      ),
                    );
                  })
                  .catchError((e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Makine bilgileri yüklenemedi.'),
                      ),
                    );
                  });
            },
            tooltip: 'Proses Kontrol',
          ),
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              _machineService
                  .getVncConnectionInfo(widget.machineId)
                  .then((connectionInfo) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            VncViewerPage(connectionInfo: connectionInfo),
                      ),
                    );
                  })
                  .catchError((e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('VNC bağlantı bilgileri yüklenemedi.'),
                      ),
                    );
                  });
            },
            tooltip: 'VNC Görüntüleyici',
          ),
        ],
      ),
      body: FutureBuilder<FullMachineStatus>(
        future: _machineDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Makine detayı bulunamadı.'));
          } else {
            final machine = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      machine.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Image.network(
                            machine.imageUrl,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 200),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      // Su Tankı Göstergesi
                      WaterTankGauge(
                        fillPercentage:
                            0.75, // API'den gelen değere göre bu kısım dinamikleştirilebilir.
                        height: 200,
                        width: 100,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Card(
                    elevation: 4,
                    child: ListTile(
                      leading: const Icon(Icons.info, color: Colors.blue),
                      title: const Text('Durum'),
                      trailing: Text(
                        machine.status,
                        style: TextStyle(
                          color: machine.status == 'Çalışıyor'
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    child: ListTile(
                      leading: const Icon(
                        Icons.thermostat,
                        color: Colors.orange,
                      ),
                      title: const Text('Sıcaklık'),
                      trailing: Text('${machine.temperature}°C'),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    child: ListTile(
                      leading: const Icon(Icons.speed, color: Colors.blue),
                      title: const Text('Hız (RPM)'),
                      trailing: Text('${machine.rpm} rpm'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Aktif Reçete Bilgileri',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 4,
                    child: ListTile(
                      leading: const Icon(Icons.list_alt, color: Colors.purple),
                      title: const Text('Reçete Adı'),
                      trailing: Text(machine.currentRecipe),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    child: ListTile(
                      leading: const Icon(Icons.layers, color: Colors.cyan),
                      title: const Text('Mevcut Adım'),
                      trailing: Text('${machine.currentStep}'),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    child: ListTile(
                      leading: const Icon(
                        Icons.data_usage,
                        color: Colors.green,
                      ),
                      title: const Text('Adım Değeri'),
                      trailing: Text('${machine.currentStepValue}'),
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
}
