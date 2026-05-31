import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String namaUser = "Nama User";
  final String emailUser = "user@email.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // 🔥 HEADER PROFIL
          Container(
            padding: EdgeInsets.only(top: 60, bottom: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.green.shade300],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                  backgroundColor: Colors.green,
                ),
                SizedBox(height: 10),
                Text(
                  namaUser,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(emailUser, style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),

          SizedBox(height: 20),

          // 🔥 CARD INFO USER
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInfoRow(Icons.person, "Nama", namaUser),
                    Divider(),

                    _buildInfoRow(Icons.email, "Email", emailUser),
                    Divider(),

                    _buildInfoRow(Icons.location_on, "Alamat", "Indonesia"),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 20),

          // 🔥 MENU
          _buildMenu(Icons.favorite, "Favorit Saya"),
          _buildMenu(Icons.history, "Riwayat Kunjungan"),
          _buildMenu(Icons.settings, "Pengaturan"),

          Divider(),

          // 🔥 LOGOUT
          _buildMenu(Icons.logout, "Logout", isLogout: true),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  // 🔧 INFO ROW
  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.green),
        SizedBox(width: 10),
        Expanded(child: Text(title)),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  // 🔧 MENU ITEM
  Widget _buildMenu(IconData icon, String title, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.green),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
