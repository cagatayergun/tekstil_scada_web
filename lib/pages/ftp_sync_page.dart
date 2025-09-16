import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/models/ftp_settings.dart';
import 'package:tekstil_scada_web/services/settings_service.dart';

class FtpSyncPage extends StatefulWidget {
  const FtpSyncPage({Key? key}) : super(key: key);

  @override
  _FtpSyncPageState createState() => _FtpSyncPageState();
}

class _FtpSyncPageState extends State<FtpSyncPage> {
  late Future<FtpSettings> _ftpSettings;
  final SettingsService _settingsService = SettingsService();
  final _hostController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _remotePathController = TextEditingController();
  bool _isEnabled = false;
  bool _isSaving = false;
  String? _message;

  @override
  void initState() {
    super.initState();
    _ftpSettings = _settingsService.getFtpSettings();
  }

  Future<void> _updateSettings() async {
    setState(() {
      _isSaving = true;
      _message = null;
    });
    final newSettings = FtpSettings(
      host: _hostController.text,
      username: _usernameController.text,
      password: _passwordController.text,
      remotePath: _remotePathController.text,
      isEnabled: _isEnabled,
    );
    try {
      await _settingsService.updateFtpSettings(newSettings);
      setState(() {
        _message = 'Ayarlar başarıyla güncellendi.';
      });
    } catch (e) {
      setState(() {
        _message = 'Hata: $e';
      });
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  Future<void> _startSync() async {
    setState(() {
      _message = 'Senkronizasyon başlatılıyor...';
    });
    try {
      await _settingsService.startFtpSync();
      setState(() {
        _message = 'Senkronizasyon başarıyla başlatıldı.';
      });
    } catch (e) {
      setState(() {
        _message = 'Hata: $e';
      });
    }
  }

  @override
  void dispose() {
    _hostController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _remotePathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FTP Senkronizasyonu')),
      body: FutureBuilder<FtpSettings>(
        future: _ftpSettings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('FTP ayarı bulunamadı.'));
          } else {
            final settings = snapshot.data!;
            _hostController.text = settings.host;
            _usernameController.text = settings.username;
            _passwordController.text = settings.password;
            _remotePathController.text = settings.remotePath;
            _isEnabled = settings.isEnabled;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_message != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      color: _message!.startsWith('Hata')
                          ? Colors.red.shade100
                          : Colors.green.shade100,
                      child: Row(
                        children: [
                          Icon(
                            _message!.startsWith('Hata')
                                ? Icons.error
                                : Icons.check_circle,
                            color: _message!.startsWith('Hata')
                                ? Colors.red
                                : Colors.green,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _message!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 24),
                  SwitchListTile(
                    title: const Text('Senkronizasyonu Etkinleştir'),
                    value: _isEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _isEnabled = value;
                      });
                    },
                  ),
                  TextField(
                    controller: _hostController,
                    decoration: const InputDecoration(
                      labelText: 'FTP Sunucu Adresi (Host)',
                    ),
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Kullanıcı Adı',
                    ),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Şifre'),
                    obscureText: true,
                  ),
                  TextField(
                    controller: _remotePathController,
                    decoration: const InputDecoration(
                      labelText: 'Uzak Klasör Yolu',
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isSaving ? null : _updateSettings,
                          child: _isSaving
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text('Ayarları Kaydet'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _startSync,
                          child: const Text('Senkronizasyonu Başlat'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
