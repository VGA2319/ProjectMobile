import 'package:flutter/material.dart';
import '../data/favorite_data.dart';
import '../screens/detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorit Saya"),
        centerTitle: true,
      ),
      body: FavoriteData.favorites.isEmpty
          ? const Center(
              child: Text(
                "Belum ada destinasi favorit",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: FavoriteData.favorites.length,
              itemBuilder: (context, index) {
                final wisata = FavoriteData.favorites[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.asset(
                      wisata.image,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(wisata.name),
                    subtitle: Text(
                      "⭐ ${wisata.rating}",
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(
                            wisata: wisata,
                          ),
                        ),
                      ).then((_) {
                        setState(() {});
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}