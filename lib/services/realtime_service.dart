// lib/services/realtime_service.dart dosyasını güncelleyin.
import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../models/live_event.dart';

class RealtimeService {
  final _controller = StreamController<LiveEvent>.broadcast();
  late WebSocketChannel _channel;

  // Gerçek zamanlı olayları dışarıya aktarmak için stream.
  Stream<LiveEvent> get events => _controller.stream;

  void startConnection() {
    // API'nizin SignalR hub URL'ini güncelleyin.
    // 'ws' veya 'wss' protokolünü kullanın.
    final hubUrl = Uri.parse('ws://tekstilscada-api.com/machinehub');

    _channel = WebSocketChannel.connect(hubUrl);

    // Web soket bağlantısını dinlemeye başlayın.
    _channel.stream.listen(
      (data) {
        final decodedData = jsonDecode(data);
        if (decodedData is Map && decodedData['type'] == 1) {
          // 1 = Invocation
          final eventData = decodedData['arguments'][0];
          final event = LiveEvent.fromJson(eventData);
          _controller.add(event); // Gelen olayı streame ekleyin.
        }
      },
      onDone: () {
        print('SignalR bağlantısı kapandı.');
        // Bağlantı koparsa yeniden bağlanmayı deneyebilirsiniz.
      },
      onError: (error) => print('SignalR bağlantı hatası: $error'),
    );

    // Hub'a bağlanmak için SignalR protokol mesajı gönderin.
    _channel.sink.add(jsonEncode({'protocol': 'json', 'version': 1}));
    _channel.sink.add(jsonEncode({'type': 6})); // Ping mesajı
  }

  void stopConnection() {
    _channel.sink.close();
    _controller.close();
  }

  // Bağlantıyı kurduktan sonra olayları dinlemek için çağrılacak bir metot.
  void subscribeToEvents(void Function(LiveEvent) onEvent) {
    events.listen(onEvent);
  }
}
