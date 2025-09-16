class ProductionReportItem {
  final int id;
  final DateTime date;
  final String productName;
  final double quantity;
  final String unit;
  final String machineName;

  ProductionReportItem({
    required this.id,
    required this.date,
    required this.productName,
    required this.quantity,
    required this.unit,
    required this.machineName,
  });

  factory ProductionReportItem.fromJson(Map<String, dynamic> json) {
    return ProductionReportItem(
      id: json['id'],
      date: DateTime.parse(json['date']),
      productName: json['productName'],
      quantity: json['quantity'].toDouble(),
      unit: json['unit'],
      machineName: json['machineName'],
    );
  }
}
