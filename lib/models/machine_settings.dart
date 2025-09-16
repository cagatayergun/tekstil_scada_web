class MachineSettings {
  final int id;
  final String machineName;
  final String ipAddress;
  final int plcPort;
  final String plcType;

  MachineSettings({
    required this.id,
    required this.machineName,
    required this.ipAddress,
    required this.plcPort,
    required this.plcType,
  });

  factory MachineSettings.fromJson(Map<String, dynamic> json) {
    return MachineSettings(
      id: json['id'],
      machineName: json['machineName'],
      ipAddress: json['ipAddress'],
      plcPort: json['plcPort'],
      plcType: json['plcType'],
    );
  }
}
