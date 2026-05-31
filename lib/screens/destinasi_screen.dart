import 'package:flutter/material.dart';
import '../data/wisata_data.dart';
import '../widgets/wisata_card.dart';

class DestinasiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Destinasi Desa"),
        centerTitle: true,
      ),
      body: ListView(
        children: [

          // 🔥 WISATA
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Tempat Wisata",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          ...wisataList.map((w) => WisataCard(wisata: w)).toList(),

          // 🔥 KULINER
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Kuliner & Warung",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          ...kulinerList.map((w) => WisataCard(wisata: w)).toList(),
        ],
      ),
    );
  }
}