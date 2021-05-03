import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wallpaper_app/fullPage.dart';

class CategoryScreem extends StatefulWidget {
  final String category;
  CategoryScreem({this.category});
  @override
  _CategoryScreemState createState() => _CategoryScreemState();
}

class _CategoryScreemState extends State<CategoryScreem> {
  List images0 = [];
  int pages = 1;

  getCATWallpaper() async {
    await http.get(
        Uri.parse(
          "https://api.pexels.com/v1/search?query=${widget.category}&per_page=80&page=1",
        ),
        headers: {
          "Authorization":
              "563492ad6f91700001000001914b851b9b2b4053bbcc76fe059a05bf"
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images0 = result['photos'];
      });
    });
  }

  loadMore() async {
    setState(() {
      pages = pages + 1;
    });
    String url =
        'https://api.pexels.com/v1/search?query=${widget.category}&per_page=80&page=' +
            pages.toString();
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          '563492ad6f91700001000001914b851b9b2b4053bbcc76fe059a05bf'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images0.addAll(result['photos']);
      });
    });
  }

  void initState() {
    getCATWallpaper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 17) +
                        EdgeInsets.only(top: 15),
                    child: GridView.builder(
                        itemCount: images0.length,
                        shrinkWrap: true,
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
                                    imageUrl: images0[index]['src']['large2x'],
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
                                          images0[index]['src']['tiny']))),
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
