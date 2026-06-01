import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/main_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Desa Wisata',

      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xffF5F7FB),

        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),

        fontFamily: 'Poppins',
      ),

      darkTheme: ThemeData.dark(),

      // Cek token dulu, kalau sudah login langsung ke MainScreen
      home: const AuthGate(),

      routes: {
        '/login': (context) => const LoginScreen(),
        '/main': (context) =>  MainScreen(),
      },
    );
  }
}

// Widget untuk cek status login
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    _cekLogin();
  }

  Future<void> _cekLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (mounted) {
      if (token != null && token.isNotEmpty) {
        // Sudah login → ke halaman utama
        Navigator.pushReplacementNamed(context, '/main');
      } else {
        // Belum login → ke halaman login
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Loading sementara sambil cek token
    return const Scaffold(
      backgroundColor: Color(0xffF5F7FB),
      body: Center(
        child: CircularProgressIndicator(color: Colors.teal),
      ),
    );
  }
}