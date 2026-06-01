import 'package:flutter/material.dart';
import '../utils/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _alamatController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _register() async {
    final nama = _namaController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final alamat = _alamatController.text.trim();

    if (nama.isEmpty || email.isEmpty || password.isEmpty) {
      _showSnackbar('Nama, email, dan password wajib diisi.', isError: true);
      return;
    }

    if (password.length < 6) {
      _showSnackbar('Password minimal 6 karakter.', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    final result = await ApiService.register(
      nama: nama,
      email: email,
      password: password,
      alamat: alamat.isEmpty ? null : alamat,
    );

    setState(() => _isLoading = false);

    if (result['success'] == true) {
      _showSnackbar('Registrasi berhasil! Silakan login.');
      if (mounted) Navigator.pop(context);
    } else {
      _showSnackbar(result['message'] ?? 'Registrasi gagal.', isError: true);
    }
  }

  void _showSnackbar(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red : Colors.teal,
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F7FB),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: const Text('Buat Akun Baru'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            /// NAMA
            const Text('Nama Lengkap', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _namaController,
              decoration: _inputDecoration('Masukkan nama lengkap', Icons.person_outline),
            ),

            const SizedBox(height: 20),

            /// EMAIL
            const Text('Email', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: _inputDecoration('Masukkan email', Icons.email_outlined),
            ),

            const SizedBox(height: 20),

            /// PASSWORD
            const Text('Password', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: _inputDecoration('Minimal 6 karakter', Icons.lock_outline).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// ALAMAT
            const Text('Alamat (Opsional)', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _alamatController,
              decoration: _inputDecoration('Masukkan alamat', Icons.location_on_outlined),
            ),

            const SizedBox(height: 32),

            /// TOMBOL REGISTER
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Daftar Sekarang',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Sudah punya akun? '),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    'Masuk di sini',
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.teal),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.teal),
      ),
    );
  }
}