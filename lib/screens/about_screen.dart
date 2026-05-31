import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tentang $namaDesa"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "$namaDesa adalah desa wisata yang memiliki keindahan alam, budaya lokal, dan potensi wisata yang menarik untuk dikunjungi.",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}