import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/api_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String namaUser = "Memuat...";
  String emailUser = "Memuat...";
  String alamatUser = "-";

  bool _isLoading = true;

  File? _profileImage;
  String nickname = "";

  @override
  void initState() {
    super.initState();
    _loadProfil();
    _loadLocalData();
  }

  Future<void> _loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    final imagePath = prefs.getString('profile_image');
    final savedNickname = prefs.getString('nickname');

    if (imagePath != null && File(imagePath).existsSync()) {
      _profileImage = File(imagePath);
    }

    if (savedNickname != null) {
      nickname = savedNickname;
    }

    setState(() {});
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedFile != null) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(
        'profile_image',
        pickedFile.path,
      );

      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _editNickname() async {
    final controller = TextEditingController(
      text: nickname.isEmpty ? namaUser : nickname,
    );

    final result = await showDialog<String>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Edit Nickname'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Masukkan nickname',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  controller.text.trim(),
                );
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(
        'nickname',
        result,
      );

      setState(() {
        nickname = result;
      });
    }
  }

  Future<void> _loadProfil() async {
    final savedUser = await ApiService.getSavedUser();

    if (savedUser != null) {
      setState(() {
        namaUser = savedUser['nama'] ?? '-';
        emailUser = savedUser['email'] ?? '-';
        alamatUser = savedUser['alamat'] ?? '-';
        _isLoading = false;
      });
    }

    final result = await ApiService.getProfil();

    if (result['success'] == true) {
      final user = result['data'];

      setState(() {
        namaUser = user['nama'] ?? '-';
        emailUser = user['email'] ?? '-';
        alamatUser = user['alamat'] ?? '-';
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _logout() async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Logout'),
        content: const Text('Yakin ingin keluar dari akun?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(
              'Batal',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (konfirmasi == true) {
      await ApiService.logout();

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F7FB),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            )
          : ListView(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 60,
                    bottom: 30,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff14B8A6),
                        Color(0xff0EA5E9),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white24,
                              backgroundImage: _profileImage != null
                                  ? FileImage(_profileImage!)
                                  : null,
                              child: _profileImage == null
                                  ? const Icon(
                                      Icons.person,
                                      size: 55,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: InkWell(
                                onTap: _pickImage,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 18,
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      GestureDetector(
                        onTap: _editNickname,
                        child: Text(
                          nickname.isNotEmpty
                              ? nickname
                              : namaUser,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      GestureDetector(
                        onTap: _editNickname,
                        child: const Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              size: 16,
                              color: Colors.white70,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Edit Nickname",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        emailUser,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildInfoRow(
                            Icons.person,
                            "Nama",
                            namaUser,
                          ),
                          const Divider(),
                          _buildInfoRow(
                            Icons.email,
                            "Email",
                            emailUser,
                          ),
                          const Divider(),
                          _buildInfoRow(
                            Icons.location_on,
                            "Alamat",
                            alamatUser,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                _buildMenu(
                  Icons.favorite,
                  "Favorit Saya",
                  onTap: () {},
                ),

                _buildMenu(
                  Icons.history,
                  "Riwayat Kunjungan",
                  onTap: () {},
                ),

                _buildMenu(
                  Icons.settings,
                  "Pengaturan",
                  onTap: () {},
                ),

                const Divider(),

                _buildMenu(
                  Icons.logout,
                  "Logout",
                  isLogout: true,
                  onTap: _logout,
                ),

                const SizedBox(height: 30),
              ],
            ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.teal,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenu(
    IconData icon,
    String title, {
    bool isLogout = false,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout
            ? Colors.red
            : Colors.teal,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout
              ? Colors.red
              : Colors.black87,
          fontWeight: isLogout
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
 }