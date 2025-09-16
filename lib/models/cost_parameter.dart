class CostParameter {
  final int id;
  final String name;
  final double value;
  final String unit;

  CostParameter({
    required this.id,
    required this.name,
    required this.value,
    required this.unit,
  });

  factory CostParameter.fromJson(Map<String, dynamic> json) {
    return CostParameter(
      id: json['id'],
      name: json['name'],
      value: json['value'].toDouble(),
      unit: json['unit'],
    );
  }
}
