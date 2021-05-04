import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wallpaper_app/UI/fullPage.dart';

class CategoryScreem extends StatefulWidget {
  final String category;
  CategoryScreem({this.category});
  @override
  _CategoryScreemState createState() => _CategoryScreemState();
}

class _CategoryScreemState extends State<CategoryScreem> {
  List images0 = [];
  int pages = 1;
  bool isBottom = false;
  ScrollController _controller = new ScrollController();

  getCATWallpaper() async {
    await http.get(
        Uri.parse(
          "https://api.pexels.com/v1/search?query=${widget.category}&per_page=80&page=1",
        ),
        headers: {
          "Authorization":
              "563492ad6f91700001000001228961f433c9477d9bbd66359079c8c7"
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
          '563492ad6f91700001000001228961f433c9477d9bbd66359079c8c7'
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
    _controller.addListener(() {
      if (_controller.offset == _controller.position.maxScrollExtent) {
        loadMore();
      }
    });
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
                        controller: _controller,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
