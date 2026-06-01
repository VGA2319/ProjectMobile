import 'package:flutter/material.dart';
import '../models/wisata.dart';
import '../screens/detail_screen.dart';

class WisataCard extends StatelessWidget {
  final Wisata wisata;

  const WisataCard({
    super.key,
    required this.wisata,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(wisata: wisata),
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.white,

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),

              child: Stack(
                children: [
                  Image.asset(
                    wisata.image,
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  Positioned(
                    top: 15,
                    right: 15,

                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 18,
                          ),

                          const SizedBox(width: 4),

                          Text(
                            wisata.rating.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            /// CONTENT
            Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    wisata.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    wisata.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [

                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          const Text(
                            "Harga Tiket",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),

                          Text(
                            wisata.price,
                            style: const TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      ElevatedButton(
                        onPressed: () {},

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                        ),

                        child: const Text(
                          "Explore",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}