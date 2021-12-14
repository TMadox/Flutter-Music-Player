import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/Logic/Control/ReadMusic.dart';
import 'package:musicplayer/Logic/Misc/ScreenSize.dart';
import 'package:musicplayer/Presentation/Screens/SongsScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ReadMusic _musicFilesObject = ReadMusic();
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
        splashIconSize: screenWidth(context) * 0.6,
        duration: 0,
        splash: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "Assets/SplashScreenLogo.png",
            scale: 5,
          ),
        ]),
        backgroundColor: Colors.black,
        screenFunction: () async {
          await _musicFilesObject.getAllFiles(showHidden: true, context: context);
          return SongsScreen();
        });
  }
}
