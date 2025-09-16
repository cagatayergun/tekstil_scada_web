// lib/pages/process_monitoring_page.dart dosyasını güncelleyin.
import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/machine_status.dart';
import 'package:tekstil_scada_web/services/machine_service.dart';
import 'package:tekstil_scada_web/widgets/machine_status_card.dart';
import 'machine_detail_page.dart'; // Bu satırı ekleyin.

class ProcessMonitoringPage extends StatefulWidget {
  const ProcessMonitoringPage({Key? key}) : super(key: key);

  @override
  _ProcessMonitoringPageState createState() => _ProcessMonitoringPageState();
}

class _ProcessMonitoringPageState extends State<ProcessMonitoringPage> {
  late Future<List<MachineStatus>> _machineStatuses;
  final MachineService _machineService = MachineService();

  @override
  void initState() {
    super.initState();
    _machineStatuses = _machineService.getMachineStatuses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Proses İzleme')),
      body: FutureBuilder<List<MachineStatus>>(
        future: _machineStatuses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Makine verisi bulunamadı.'));
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final machine = snapshot.data![index];
                return GestureDetector(
                  // Tıklama özelliği ekler.
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            MachineDetailPage(machineId: machine.id),
                      ),
                    );
                  },
                  child: MachineStatusCard(machineStatus: machine),
                );
              },
            );
          }
        },
      ),
    );
  }
}
