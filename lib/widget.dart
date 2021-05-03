import 'package:flutter/material.dart';
import 'package:wallpaper_app/cat_screen.dart';

class CatWidget extends StatelessWidget {
  final String imgUrl;
  final String catname;
  CatWidget({this.catname, this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CategoryScreem(
                          category: catname,
                        )));
          },
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imgUrl,
                fit: BoxFit.cover,
                height: 145,
                width: 130,
              ),
            ),
          ),
        ),
        Container(
          child: Text(catname),
        )
      ],
    );
  }
}
