class ManualUsageReportItem {
  final DateTime date;
  final String machineName;
  final String materialName;
  final double quantity;
  final String unit;
  final String userName;

  ManualUsageReportItem({
    required this.date,
    required this.machineName,
    required this.materialName,
    required this.quantity,
    required this.unit,
    required this.userName,
  });

  factory ManualUsageReportItem.fromJson(Map<String, dynamic> json) {
    return ManualUsageReportItem(
      date: DateTime.parse(json['date']),
      machineName: json['machineName'],
      materialName: json['materialName'],
      quantity: json['quantity'].toDouble(),
      unit: json['unit'],
      userName: json['userName'],
    );
  }
}
