// Gerekli paketleri ve kütüphaneleri içe aktarın.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Bu dosyada henüz oluşturulmamış ancak başarılı girişte yönlendirilecek sayfa.
import 'dashboard_page.dart';

// Giriş sayfası widget'ı bir durum yönetimi (Stateful) widget'ı olarak tanımlanır.
// Bu, formun durumunu (yükleniyor, hata mesajı vb.) yönetmemizi sağlar.
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Form alanları için controller'lar tanımlayın.
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // UI durumunu yönetmek için değişkenler.
  String? _errorMessage;
  bool _isLoading = false;

  // Giriş butonuna tıklandığında çalışacak fonksiyon.
  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final username = _usernameController.text;
    final password = _passwordController.text;

    // API'ye göndereceğimiz veri.
    final loginData = jsonEncode({'username': username, 'password': password});

    try {
      // API'ye POST isteği gönder.
      // API URL'ini kendi sunucunuzun adresiyle değiştirmeyi unutmayın.
      // Örn: 'http://localhost:5000/api/Auth/login'
      final response = await http.post(
        Uri.parse('https://tekstilscada-api.com/api/Auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: loginData,
      );

      // Başarılı giriş.
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        // Token'ı yerel depolamaya kaydet.
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);

        // Kullanıcıyı ana sayfaya yönlendir.
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      } else if (response.statusCode == 401) {
        // Hatalı kullanıcı adı veya şifre.
        setState(() {
          _errorMessage = 'Geçersiz kullanıcı adı veya şifre.';
        });
      } else {
        // Diğer API hataları.
        setState(() {
          _errorMessage = 'Giriş işlemi başarısız oldu. Lütfen tekrar deneyin.';
        });
      }
    } catch (e) {
      // Ağ bağlantı hatası veya diğer istisnalar.
      setState(() {
        _errorMessage = 'Sunucuya bağlanılamıyor: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sayfanın genel düzenini sağlayan ana widget.
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Başlık.
                    Text(
                      'Giriş Yap',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),

                    // Kullanıcı Adı Giriş Kutusu.
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Kullanıcı Adı',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Şifre Giriş Kutusu.
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Şifre',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Hata Mesajı Bölümü.
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                    // Giriş Butonu.
                    SizedBox(
                      width: double.infinity,
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: _handleLogin,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  'Giriş',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
