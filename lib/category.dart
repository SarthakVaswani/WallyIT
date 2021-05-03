import 'package:flutter/material.dart';
import 'package:wallpaper_app/cat_model.dart';
import 'package:wallpaper_app/data.dart';
import 'package:wallpaper_app/widget.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Cat_model> categories = new List();

  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    categories = getCategory();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Text(
                "Category",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 17) +
                    EdgeInsets.only(top: 15),
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2 / 2,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return CatWidget(
                        imgUrl: categories[index].imgUrl,
                        catname: categories[index].catName,
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
