import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/user_profile.dart';
import 'package:tekstil_scada_web/services/user_service.dart';

class UserSettingsPage extends StatefulWidget {
  const UserSettingsPage({Key? key}) : super(key: key);

  @override
  _UserSettingsPageState createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  late Future<UserProfile> _userProfile;
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _userProfile = _userService.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kullanıcı Ayarları')),
      body: FutureBuilder<UserProfile>(
        future: _userProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Kullanıcı verisi bulunamadı.'));
          } else {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profil Bilgileri',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text('Kullanıcı Adı: ${user.username}'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.badge),
                    title: Text('Tam Adı: ${user.fullName}'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.supervised_user_circle),
                    title: Text('Roller: ${user.roles.join(', ')}'),
                  ),
                  const Divider(),
                  // Buraya şifre değiştirme veya profil düzenleme formu eklenebilir.
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
