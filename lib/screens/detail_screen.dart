import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/wisata.dart';
import '../utils/constants.dart';

class DetailScreen extends StatelessWidget {
  final Wisata wisata;

  DetailScreen({required this.wisata});

  void openMap() async {
    final Uri url = Uri.parse(wisata.location);
    if (!await launchUrl(url)) {
      throw 'Tidak bisa membuka maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // 🔥 GAMBAR BESAR
          Stack(
            children: [
              Image.asset(wisata.image, fit: BoxFit.cover),
              Positioned(
                top: 40,
                left: 10,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  wisata.name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 5),

                Text(namaDesa, style: TextStyle(color: Colors.grey)),

                SizedBox(height: 15),

                Text(wisata.description),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_border),
                      label: Text("Favorit"),
                    ),
                    ElevatedButton.icon(
                      onPressed: openMap,
                      icon: Icon(Icons.map),
                      label: Text("Lihat Lokasi"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
