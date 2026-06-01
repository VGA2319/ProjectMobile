import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../data/wisata_data.dart';
import '../widgets/wisata_card.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onProfileTap;

  const HomeScreen({
    super.key,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F7FB),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HERO SECTION
            Stack(
              children: [

                /// BACKGROUND IMAGE
                Container(
                  height: 380,

                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/Lembahdamai.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                /// DARK OVERLAY
                Container(
                  height: 380,
                  color: Colors.black.withOpacity(0.45),
                ),

                /// CONTENT
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        /// TOP BAR
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,

                          children: [

                            /// LOGO
                            Row(
                              children: [

                                Container(
                                  padding:
                                      const EdgeInsets.all(
                                    10,
                                  ),

                                  decoration:
                                      BoxDecoration(
                                    color: Colors.white
                                        .withOpacity(0.2),

                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      16,
                                    ),
                                  ),

                                  child: const Icon(
                                    Icons.landscape,
                                    color:
                                        Colors.white,
                                  ),
                                ),

                                const SizedBox(width: 12),

                                const Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [

                                    Text(
                                      "Desa Wisata",
                                      style: TextStyle(
                                        color:
                                            Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),

                                    Text(
                                      "SukaDadi",
                                      style: TextStyle(
                                        color:
                                            Colors.white,
                                        fontSize: 20,
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),

                            /// PROFILE
                            GestureDetector(
                              onTap: onProfileTap,

                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius
                                        .circular(50),

                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(
                                    sigmaX: 10,
                                    sigmaY: 10,
                                  ),

                                  child: Container(
                                    padding:
                                        const EdgeInsets
                                            .all(10),

                                    decoration:
                                        BoxDecoration(
                                      color: Colors
                                          .white
                                          .withOpacity(
                                        0.15,
                                      ),

                                      shape:
                                          BoxShape.circle,
                                    ),

                                    child: const Icon(
                                      Icons.person,
                                      color:
                                          Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 45),

                        /// TITLE
                        const Text(
                          "Explore\nBeautiful Nature",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight:
                                FontWeight.bold,
                            height: 1.2,
                          ),
                        ),

                        const SizedBox(height: 14),

                        const Text(
                          "Temukan wisata terbaik, kuliner khas,\ndan pengalaman desa yang menakjubkan.",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 30),

                        /// SEARCH BAR
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(20),

                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10,
                              sigmaY: 10,
                            ),

                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),

                              decoration: BoxDecoration(
                                color: Colors.white
                                    .withOpacity(0.18),

                                borderRadius:
                                    BorderRadius.circular(
                                  20,
                                ),
                              ),

                              child: const TextField(
                                style: TextStyle(
                                  color: Colors.white,
                                ),

                                decoration:
                                    InputDecoration(
                                  border:
                                      InputBorder.none,

                                  hintText:
                                      "Cari wisata...",

                                  hintStyle: TextStyle(
                                    color:
                                        Colors.white70,
                                  ),

                                  icon: Icon(
                                    Icons.search,
                                    color:
                                        Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// CATEGORY
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20),

              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: const [

                  Text(
                    "Kategori",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "Lihat Semua",
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 110,

              child: ListView(
                scrollDirection: Axis.horizontal,

                padding:
                    const EdgeInsets.symmetric(horizontal: 20),

                children: [

                  _categoryItem(
                    Icons.landscape,
                    "Alam",
                    Colors.teal,
                  ),

                  _categoryItem(
                    Icons.restaurant,
                    "Kuliner",
                    Colors.orange,
                  ),

                  _categoryItem(
                    Icons.cabin,
                    "Camping",
                    Colors.blue,
                  ),

                  _categoryItem(
                    Icons.festival,
                    "Budaya",
                    Colors.purple,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            /// POPULAR TITLE
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20),

              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: const [

                  Text(
                    "Wisata Populer",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "Explore",
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// SLIDER
            CarouselSlider(
              options: CarouselOptions(
                height: 420,
                enlargeCenterPage: true,
                autoPlay: true,
                viewportFraction: 0.80,
              ),

              items: sliderList.map((item) {
                return WisataCard(wisata: item);
              }).toList(),
            ),

            const SizedBox(height: 30),

            /// STATISTIK
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20),

              child: Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff14B8A6),
                      Color(0xff0EA5E9),
                    ],
                  ),

                  borderRadius:
                      BorderRadius.circular(30),

                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.teal.withOpacity(0.3),

                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),

                child: const Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround,

                  children: [

                    Column(
                      children: [
                        Text(
                          "10K+",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          "Pengunjung",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Text(
                          "25+",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          "Destinasi",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Text(
                          "4.9",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          "Rating",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// DESTINASI LIST
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20),

              child: const Text(
                "Semua Destinasi",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            ListView.builder(
              itemCount: wisataList.length,
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),

              itemBuilder: (context, index) {
                return WisataCard(
                  wisata: wisataList[index],
                );
              },
            ),

            const SizedBox(height: 30),

            /// CTA SECTION
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20),

              child: Container(
                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                      BorderRadius.circular(30),
                ),

                child: Column(
                  children: [

                    const Text(
                      "Nikmati Pengalaman\nWisata Terbaik",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "Temukan wisata alam, budaya,\ndan kuliner terbaik desa.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 24),

                    ElevatedButton(
                      onPressed: () {},

                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.teal,

                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),
                        ),
                      ),

                      child: const Text(
                        "Explore Sekarang",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /// CATEGORY ITEM
  Widget _categoryItem(
    IconData icon,
    String title,
    Color color,
  ) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
          )
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(0.15),

            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}