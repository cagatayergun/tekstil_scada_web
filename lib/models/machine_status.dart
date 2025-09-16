class MachineStatus {
  final int id;
  final String name;
  final String status;
  final double temperature;
  final int rpm;
  final String imageUrl;

  MachineStatus({
    required this.id,
    required this.name,
    required this.status,
    required this.temperature,
    required this.rpm,
    required this.imageUrl,
  });

  // JSON'dan MachineStatus nesnesi oluşturmak için fabrika metodu.
  factory MachineStatus.fromJson(Map<String, dynamic> json) {
    return MachineStatus(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      temperature: json['temperature'].toDouble(),
      rpm: json['rpm'],
      imageUrl: json['imageUrl'],
    );
  }
}
