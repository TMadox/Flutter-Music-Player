import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musicplayer/Data/Models/songs_model.dart';
import 'package:musicplayer/Logic/Misc/ScreenSize.dart';
import 'package:musicplayer/Logic/StateManagment/Music/MusicControlState.dart';
import 'package:musicplayer/Presentation/Screens/NowPlayingScreen.dart';
import 'package:musicplayer/Presentation/Widgets/ImageCheckWidget.dart';
import 'package:musicplayer/Presentation/Widgets/MusicControlButtonsWidget.dart';

import 'package:volume_controller/volume_controller.dart';

class NowPlayingWidget extends StatefulWidget {
  final Songmetadata playingSong;
  const NowPlayingWidget({Key? key, required this.playingSong})
      : super(key: key);

  @override
  _NowPlayingWidgetState createState() => _NowPlayingWidgetState();
}

class _NowPlayingWidgetState extends State<NowPlayingWidget> {
  Duration currentSongPosition = Duration();
  ImageCheckWidget _imageCheck = ImageCheckWidget();
  @override
  void initState() {
    VolumeController().listener((p0) {
      context.read(musicControlStateManagment).setVolume(p0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          height: screenHeight(context) * 0.1,
          color: Colors.grey.withOpacity(0.1),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      context: context,
                      builder: (context) => NowPlayingPage()),
                  child: Row(
                    children: [
                      _imageCheck.checkImage(input: widget.playingSong.image),
                      SizedBox(
                        width: screenWidth(context) * 0.05,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.playingSong.title!,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              MusicControlButtonsWidget(buttonSize: 30)
            ],
          ),
        ),
      ),
    );
  }
}
