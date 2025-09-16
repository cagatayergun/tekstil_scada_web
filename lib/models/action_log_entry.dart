class ActionLogEntry {
  final int id;
  final String machineName;
  final String action;
  final DateTime timestamp;
  final String userName;

  ActionLogEntry({
    required this.id,
    required this.machineName,
    required this.action,
    required this.timestamp,
    required this.userName,
  });

  factory ActionLogEntry.fromJson(Map<String, dynamic> json) {
    return ActionLogEntry(
      id: json['id'],
      machineName: json['machineName'],
      action: json['action'],
      timestamp: DateTime.parse(json['timestamp']),
      userName: json['userName'],
    );
  }
}
