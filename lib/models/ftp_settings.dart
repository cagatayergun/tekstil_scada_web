class FtpSettings {
  final String host;
  final String username;
  final String password;
  final String remotePath;
  final bool isEnabled;

  FtpSettings({
    required this.host,
    required this.username,
    required this.password,
    required this.remotePath,
    required this.isEnabled,
  });

  factory FtpSettings.fromJson(Map<String, dynamic> json) {
    return FtpSettings(
      host: json['host'],
      username: json['username'],
      password: json['password'],
      remotePath: json['remotePath'],
      isEnabled: json['isEnabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'host': host,
      'username': username,
      'password': password,
      'remotePath': remotePath,
      'isEnabled': isEnabled,
    };
  }
}
