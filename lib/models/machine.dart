class Machine {
  final int id;
  final String name;

  Machine({required this.id, required this.name});

  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(id: json['id'], name: json['name']);
  }
}
