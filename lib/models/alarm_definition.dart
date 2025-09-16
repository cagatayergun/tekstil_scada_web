class AlarmDefinition {
  final int id;
  final String alarmCode;
  final String description;
  final String machineName;
  final String threshold;
  final int priority;

  AlarmDefinition({
    required this.id,
    required this.alarmCode,
    required this.description,
    required this.machineName,
    required this.threshold,
    required this.priority,
  });

  factory AlarmDefinition.fromJson(Map<String, dynamic> json) {
    return AlarmDefinition(
      id: json['id'],
      alarmCode: json['alarmCode'],
      description: json['description'],
      machineName: json['machineName'],
      threshold: json['threshold'],
      priority: json['priority'],
    );
  }
}
