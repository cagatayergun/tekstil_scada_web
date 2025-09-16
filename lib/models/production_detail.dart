class ProductionDetail {
  final int id;
  final DateTime startTime;
  final DateTime? endTime;
  final String machineName;
  final String productName;
  final double producedQuantity;
  final String status;

  ProductionDetail({
    required this.id,
    required this.startTime,
    this.endTime,
    required this.machineName,
    required this.productName,
    required this.producedQuantity,
    required this.status,
  });

  factory ProductionDetail.fromJson(Map<String, dynamic> json) {
    return ProductionDetail(
      id: json['id'],
      startTime: DateTime.parse(json['startTime']),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      machineName: json['machineName'],
      productName: json['productName'],
      producedQuantity: json['producedQuantity'].toDouble(),
      status: json['status'],
    );
  }
}
