class OeeData {
  final double availability;
  final double performance;
  final double quality;
  final double oee;

  OeeData({
    required this.availability,
    required this.performance,
    required this.quality,
    required this.oee,
  });

  factory OeeData.fromJson(Map<String, dynamic> json) {
    return OeeData(
      availability: json['availability'].toDouble(),
      performance: json['performance'].toDouble(),
      quality: json['quality'].toDouble(),
      oee: json['oee'].toDouble(),
    );
  }
}
