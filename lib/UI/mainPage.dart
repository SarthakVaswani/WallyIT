import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/UI/category.dart';
import 'package:wallpaper_app/UI/homePage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    Future<bool> _exitApp(BuildContext context) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 2,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              // side: BorderSide(
              //     color: Colors.white, width: 0.01),
              borderRadius: BorderRadius.circular(10)),
          title: Text(
            'Are you sure want to Exit ?',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          actions: [
            FlatButton(
              splashColor: Colors.blueGrey,
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'No',
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
            FlatButton(
              splashColor: Colors.blueGrey,
              onPressed: () => exit(0),
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async => _exitApp(context),
      child: Scaffold(
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
                      dotHeight: 12.5,
                      dotWidth: 12.5,
                      activeDotColor: Colors.white,
                      dotColor: Colors.grey,
                    ),
                    onDotClicked: (index) => _pageController.animateToPage(
                        index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInCubic),
                  )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
