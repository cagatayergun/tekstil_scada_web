// lib/main.dart dosyasını güncelleyin.
import 'package:flutter/material.dart';
import 'package:tekstil_scada_web/pages/login_page.dart';
import 'package:tekstil_scada_web/services/realtime_service.dart';

void main() {
  final realtimeService = RealtimeService();
  realtimeService.startConnection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TekstilSCADA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Diğer tema ayarları
      ),
      home: const LoginPage(),
      // Uygulama genelinde kullanılacak diğer rotalar
      // routes: {
      //   '/dashboard': (context) => const DashboardPage(),
      //   '/recipes': (context) => const RecipeSettingsPage(),
      // },
    );
  }
}
