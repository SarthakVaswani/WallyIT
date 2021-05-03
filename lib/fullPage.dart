import 'package:flutter/material.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class FullScreen extends StatefulWidget {
  final String imageUrl;
  FullScreen({this.imageUrl});
  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  Future<void> setWallpaperHome() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
    final String result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  Future<void> setWallpaperLock() async {
    int location = WallpaperManager.LOCK_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
    final String result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  Future<void> setWallpaperBoth() async {
    int location = WallpaperManager.BOTH_SCREENS;
    var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
    final String result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.grey.shade200.withOpacity(0.5),
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MaterialButton(
                                minWidth: 200,
                                color: Colors.black,
                                elevation: 7,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "Home Screen",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                onPressed: () {
                                  setWallpaperHome();
                                  final snackBar = SnackBar(
                                      content: Text('Wallpaper changed'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.pop(context);
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            MaterialButton(
                                minWidth: 200,
                                color: Colors.black,
                                elevation: 7,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "Lock Screen",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                onPressed: () {
                                  setWallpaperLock();
                                  final snackBar = SnackBar(
                                      content: Text('Wallpaper changed'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.pop(context);
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            MaterialButton(
                                minWidth: 200,
                                color: Colors.black,
                                elevation: 7,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "Both",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                onPressed: () {
                                  setWallpaperBoth();
                                  final snackBar = SnackBar(
                                      content: Text('Wallpaper changed'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                ),
                height: 50,
                width: double.infinity,
                child: Center(
                    child: Text(
                  "Set Wallpaper",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
