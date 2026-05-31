import 'package:flutter/material.dart';
import '../data/wisata_data.dart';
import '../widgets/wisata_card.dart';
import '../utils/constants.dart';
import 'about_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onProfileTap;

  const HomeScreen({
    Key? key,
    required this.onProfileTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),

            // HEADER
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),

              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            Colors.green.shade100,

                        child: Icon(
                          Icons.landscape,
                          color: Colors.green,
                        ),
                      ),

                      SizedBox(width: 10),

                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Desa Wisata",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),

                          Text(
                            "SukaDadi Pesawaran",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      GestureDetector(
                        onTap: onProfileTap,

                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor:
                              Colors.grey.shade300,

                          child: Icon(
                            Icons.person,
                            size: 20,
                          ),
                        ),
                      ),

                      SizedBox(width: 10),

                      Container(
                        padding: EdgeInsets.all(8),

                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),

                        child: Icon(
                          Icons.search,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // SLIDER
            CarouselSlider(
              options: CarouselOptions(
                height: 180,
                autoPlay: false,
                enlargeCenterPage: true,
              ),

              items: sliderList.map((item) {
                return Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 8),

                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(15),

                    image: DecorationImage(
                      image: AssetImage(item.image),
                      fit: BoxFit.cover,
                    ),
                  ),

                  child: Container(
                    padding: EdgeInsets.all(15),

                    alignment: Alignment.bottomLeft,

                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(15),

                      color: Colors.black.withOpacity(0.3),
                    ),

                    child: Text(
                      item.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            // TITLE
            Padding(
              padding: EdgeInsets.all(16),

              child: Text(
                "Destinasi Populer",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // LIST
            ListView.builder(
              shrinkWrap: true,
              physics:
                  NeverScrollableScrollPhysics(),

              itemCount: wisataList.length,

              itemBuilder: (context, index) {
                return WisataCard(
                  wisata: wisataList[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}