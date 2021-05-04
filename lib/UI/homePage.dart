import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/UI/fullPage.dart';

class WallpaperHome extends StatefulWidget {
  @override
  _WallpaperHomeState createState() => _WallpaperHomeState();
}

class _WallpaperHomeState extends State<WallpaperHome> {
  List images = [];
  int page = 1;
  bool isBottom = false;
  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    fetchAPI();
    _controller.addListener(() {
      if (_controller.offset == _controller.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  fetchAPI() async {
    await http.get(
        Uri.parse('https://api.pexels.com/v1/curated?per_page=80&page=1'),
        headers: {
          'Authorization':
              '563492ad6f91700001000001228961f433c9477d9bbd66359079c8c7'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
      // print(images);
    });
  }

  loadMore() async {
    setState(() {
      page = page + 1;
    });
    String url =
        'https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString();
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          '563492ad6f91700001000001228961f433c9477d9bbd66359079c8c7'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                child: Text(
                  "Trending",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 17) +
                          EdgeInsets.only(top: 15),
                      child: GridView.builder(
                          controller: _controller,
                          itemCount: images.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 10,
                                  crossAxisCount: 2,
                                  childAspectRatio: 7 / 10,
                                  mainAxisSpacing: 25),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreen(
                                      imageUrl: images[index]['src']['large2x'],
                                    ),
                                  ),
                                );
                              },
                              // Image.network(
                              //     images[index]['src']['tiny'],
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            images[index]['src']['tiny']))),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
