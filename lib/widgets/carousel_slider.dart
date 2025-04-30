import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';

class CarouselSliders extends StatelessWidget {
  const CarouselSliders({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return CarouselSlider(
      options: CarouselOptions(
        height: screenHeight * 0.15,
        aspectRatio: 10 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items:
          [
            "assets/images/Mobile_banner_about.png",
            "assets/images/Mobile_banner2.png",
            "assets/images/Mobile_banner3.png",
          ].map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 0.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 154, 152, 152),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    item,
                    fit: BoxFit.cover,
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.2,
                  ),
                );
              },
            );
          }).toList(),
    );
  }
}
