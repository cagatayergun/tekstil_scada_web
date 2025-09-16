import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/services/machine_service.dart';
import 'package:tekstil_scada_web/models/process_control_command.dart';

class ProcessControlPage extends StatefulWidget {
  final int machineId;
  final String machineName;

  const ProcessControlPage({
    Key? key,
    required this.machineId,
    required this.machineName,
  }) : super(key: key);

  @override
  _ProcessControlPageState createState() => _ProcessControlPageState();
}

class _ProcessControlPageState extends State<ProcessControlPage> {
  final MachineService _machineService = MachineService();
  bool _isSending = false;
  String? _message;

  Future<void> _sendCommand(String commandType) async {
    setState(() {
      _isSending = true;
      _message = null;
    });

    final command = ProcessControlCommand(
      machineId: widget.machineId,
      commandType: commandType,
      parameters: {},
    );

    try {
      await _machineService.sendControlCommand(command);
      setState(() {
        _message = 'Komut başarıyla gönderildi: $commandType';
      });
    } catch (e) {
      setState(() {
        _message = 'Hata: $e';
      });
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.machineName} - Proses Kontrol')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_message != null)
              Container(
                padding: const EdgeInsets.all(12),
                color: _message!.startsWith('Hata')
                    ? Colors.red.shade100
                    : Colors.green.shade100,
                child: Row(
                  children: [
                    Icon(
                      _message!.startsWith('Hata')
                          ? Icons.error
                          : Icons.check_circle,
                      color: _message!.startsWith('Hata')
                          ? Colors.red
                          : Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _message!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildControlButton(
                  label: 'Başlat',
                  icon: Icons.play_arrow,
                  color: Colors.green,
                  onPressed: () => _sendCommand('start'),
                ),
                _buildControlButton(
                  label: 'Durdur',
                  icon: Icons.stop,
                  color: Colors.red,
                  onPressed: () => _sendCommand('stop'),
                ),
                _buildControlButton(
                  label: 'Sıfırla',
                  icon: Icons.refresh,
                  color: Colors.blue,
                  onPressed: () => _sendCommand('reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: _isSending ? null : onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            color, // 'primary' yerine 'backgroundColor' kullanıldı.
        foregroundColor:
            Colors.white, // 'onPrimary' yerine 'foregroundColor' kullanıldı.
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
