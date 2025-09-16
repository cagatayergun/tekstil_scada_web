class LiveEvent {
  final String eventType;
  final String message;
  final DateTime timestamp;
  final String machineName;

  LiveEvent({
    required this.eventType,
    required this.message,
    required this.timestamp,
    required this.machineName,
  });

  factory LiveEvent.fromJson(Map<String, dynamic> json) {
    return LiveEvent(
      eventType: json['eventType'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
      machineName: json['machineName'],
    );
  }
}