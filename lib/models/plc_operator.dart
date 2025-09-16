class PlcOperator {
  final int id;
  final String name;
  final String password;
  final int level;

  PlcOperator({
    required this.id,
    required this.name,
    required this.password,
    required this.level,
  });

  factory PlcOperator.fromJson(Map<String, dynamic> json) {
    return PlcOperator(
      id: json['id'],
      name: json['name'],
      password: json['password'],
      level: json['level'],
    );
  }
}
