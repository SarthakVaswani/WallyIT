import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/fullPage.dart';

class WallpaperHome extends StatefulWidget {
  @override
  _WallpaperHomeState createState() => _WallpaperHomeState();
}

class _WallpaperHomeState extends State<WallpaperHome> {
  List images = [];
  int page = 1;
  @override
  void initState() {
    super.initState();
    fetchAPI();
  }

  fetchAPI() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
              '563492ad6f91700001000001914b851b9b2b4053bbcc76fe059a05bf'
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
          '563492ad6f91700001000001914b851b9b2b4053bbcc76fe059a05bf'
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
                "New",
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
                        itemCount: images.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        loadMore();
                        final snackBar = SnackBar(
                          content: Text('More Wallpapers loaded'),
                          duration: Duration(milliseconds: 200),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      backgroundColor: Colors.white,
                      child: Icon(Icons.refresh),
                    ),
                  ),
                ],
              ),
            ),

            // InkWell(
            //   onTap: () {
            //     loadMore();
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     height: 50,
            //     width: double.infinity,
            //     child: Center(
            //         child: Text(
            //       "Load More",
            //       style: TextStyle(color: Colors.black, fontSize: 30),
            //     )),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
