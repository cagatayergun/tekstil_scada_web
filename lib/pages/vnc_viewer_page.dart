import 'package:flutter/material.dart';
import 'package:flutter_rfb/flutter_rfb.dart';
import 'package:tekstil_scada_web/models/vnc_connection_info.dart';

class VncViewerPage extends StatelessWidget {
  final VncConnectionInfo connectionInfo;

  const VncViewerPage({Key? key, required this.connectionInfo})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${connectionInfo.host} VNC')),
      body: Center(
        child: RemoteFrameBufferWidget(
          hostName: connectionInfo.host, // 'host' yerine 'hostName' kullanıldı.
          port: connectionInfo.port,
          password: connectionInfo.password ?? '',
        ),
      ),
    );
  }
}
