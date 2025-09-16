class UserProfile {
  final int id;
  final String username;
  final String fullName;
  final List<String> roles;

  UserProfile({
    required this.id,
    required this.username,
    required this.fullName,
    required this.roles,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      username: json['username'],
      fullName: json['fullName'],
      roles: List<String>.from(json['roles']),
    );
  }
}
