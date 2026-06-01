import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/wisata.dart';
import '../utils/constants.dart';
import '../data/favorite_data.dart';

class DetailScreen extends StatefulWidget {
  final Wisata wisata;

  const DetailScreen({
    super.key,
    required this.wisata,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  void openMap() async {
    final Uri url = Uri.parse(widget.wisata.location);

    if (!await launchUrl(url)) {
      throw 'Tidak bisa membuka maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isFavorite =
        FavoriteData.isFavorite(widget.wisata);

    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Image.asset(
                widget.wisata.image,
                fit: BoxFit.cover,
              ),

              Positioned(
                top: 40,
                left: 10,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.wisata.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  namaDesa,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 15),

                Text(widget.wisata.description),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          FavoriteData.toggleFavorite(
                            widget.wisata,
                          );
                        });

                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          SnackBar(
                            content: Text(
                              FavoriteData.isFavorite(
                                      widget.wisata)
                                  ? 'Ditambahkan ke Favorit'
                                  : 'Dihapus dari Favorit',
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      label: Text(
                        isFavorite
                            ? "Favorit"
                            : "Tambah Favorit",
                      ),
                    ),

                    ElevatedButton.icon(
                      onPressed: openMap,
                      icon: const Icon(Icons.map),
                      label:
                          const Text("Lihat Lokasi"),
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