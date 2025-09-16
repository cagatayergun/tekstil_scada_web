class VncConnectionInfo {
  final String host;
  final int port;
  final String? password;

  VncConnectionInfo({required this.host, required this.port, this.password});

  factory VncConnectionInfo.fromJson(Map<String, dynamic> json) {
    return VncConnectionInfo(
      host: json['host'],
      port: json['port'],
      password: json['password'],
    );
  }
}
