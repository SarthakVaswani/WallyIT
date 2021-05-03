import 'package:flutter/material.dart';
import 'package:wallpaper_app/category.dart';
import 'package:wallpaper_app/homePage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              WallpaperHome(),
              CategoryPage(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(2),
                child: Center(
                    child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 2,
                  effect: WormEffect(
                    activeDotColor: Colors.white,
                    dotColor: Colors.grey,
                  ),
                  onDotClicked: (index) => _pageController.animateToPage(index,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInCubic),
                )),
              )
            ],
          )
        ],
      ),
    );
  }
}
