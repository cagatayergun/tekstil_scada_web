class AlarmReportItem {
  final int id;
  final String machineName;
  final String alarmDescription;
  final DateTime startTime;
  final DateTime? endTime;
  final double durationInMinutes;

  AlarmReportItem({
    required this.id,
    required this.machineName,
    required this.alarmDescription,
    required this.startTime,
    this.endTime,
    required this.durationInMinutes,
  });

  factory AlarmReportItem.fromJson(Map<String, dynamic> json) {
    return AlarmReportItem(
      id: json['id'],
      machineName: json['machineName'],
      alarmDescription: json['alarmDescription'],
      startTime: DateTime.parse(json['startTime']),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      durationInMinutes: json['durationInMinutes'].toDouble(),
    );
  }
}
