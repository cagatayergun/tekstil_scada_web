class TrendDataPoint {
  final DateTime timestamp;
  final double value;

  TrendDataPoint({required this.timestamp, required this.value});

  factory TrendDataPoint.fromJson(Map<String, dynamic> json) {
    return TrendDataPoint(
      timestamp: DateTime.parse(json['timestamp']),
      value: json['value'].toDouble(),
    );
  }
}
