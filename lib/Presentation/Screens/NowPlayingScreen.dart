import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musicplayer/Data/Models/songs_model.dart';
import 'package:musicplayer/Logic/Control/MusicControl.dart';
import 'package:musicplayer/Logic/Misc/ScreenSize.dart';
import 'package:musicplayer/Logic/StateManagment/Music/MusicControlState.dart';
import 'package:musicplayer/Logic/StateManagment/Music/MusicLibraryState.dart';
import 'package:musicplayer/Logic/StateManagment/Music/NowPlayingState.dart';
import 'package:musicplayer/Presentation/Widgets/ImageCheckWidget.dart';
import 'package:musicplayer/Presentation/Widgets/MusicControlButtonsWidget.dart';

import 'package:volume_controller/volume_controller.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({Key? key}) : super(key: key);

  @override
  _NowPlayingPageState createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  int currentSongIndex = 0;
  late PageController _controller;
  Duration currentSongPosition = Duration();
  ImageCheckWidget _imageCheck = ImageCheckWidget();
  MusicControl _musicObject = MusicControl();
  @override
  void initState() {
    currentSongIndex = context.read(nowPlayingStateManagment).playingSongIndex;
    _controller = PageController(initialPage: currentSongIndex);
    VolumeController().listener((p0) {
      context.read(musicControlStateManagment).setVolume(p0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Songmetadata> currentPlaylist =
        context.read(musicLibraryStateManagment).currentPlaylist;
    final Songmetadata? currentSong =
        context.read(nowPlayingStateManagment).playingSong;
    final musicControl = context.read(musicControlStateManagment);
    return Stack(
      children: [
        Consumer(
            builder: (BuildContext context,
                    T Function<T>(ProviderBase<Object?, T>) watch,
                    Widget? child) =>
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: SizedBox(
                    height: screenHeight(context),
                    child: _imageCheck.checkImage(
                        input:
                            watch(nowPlayingStateManagment).playingSong!.image),
                  ),
                )),
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(
              color: Colors.grey.withOpacity(0.3),
              child: PageView.builder(
                controller: _controller,
                itemCount: currentPlaylist.length,
                onPageChanged: (value) {
                  _musicObject.loadNewSong(
                      context: context,
                      currentPlayList: currentPlaylist,
                      song: currentPlaylist[value],
                      songIndex: value);
                },
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: Container(
                        color: Colors.grey.withOpacity(0.3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer(
                              builder: (BuildContext context,
                                      T Function<T>(ProviderBase<Object?, T>)
                                          watch,
                                      Widget? child) =>
                                  SizedBox(
                                      width: screenWidth(context) * 0.5,
                                      child: _imageCheck.checkImage(
                                          input: watch(nowPlayingStateManagment)
                                              .playingSong!
                                              .image)),
                            ),
                            SizedBox(
                              height: screenHeight(context) * 0.1,
                            ),
                            Consumer(
                              builder: (BuildContext context,
                                      T Function<T>(ProviderBase<Object?, T>)
                                          watch,
                                      Widget? child) =>
                                  ListTile(
                                title: Text(
                                  watch(nowPlayingStateManagment)
                                      .playingSong!
                                      .title!
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                subtitle: Text(
                                  watch(nowPlayingStateManagment)
                                      .playingSong!
                                      .artist!
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 20),
                                ),
                                trailing: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.more_horiz_rounded,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            StreamBuilder(
                              stream: musicControl
                                  .audioPlayer.onAudioPositionChanged,
                              builder:
                                  (context, AsyncSnapshot<Duration> snapshot) {
                                if (snapshot.hasData) {
                                  currentSongPosition = snapshot.data!;
                                  return Slider(
                                      value:
                                          snapshot.data!.inSeconds.toDouble(),
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.grey,
                                      min: 0.0,
                                      max: currentSong!.length == "0"
                                          ? 0
                                          : double.parse(currentSong.length!) /
                                              1000,
                                      onChanged: (v) {
                                        musicControl.audioPlayer
                                            .seek(Duration(seconds: v.toInt()));
                                      });
                                } else {
                                  return Slider(
                                      value: currentSongPosition.inSeconds
                                          .toDouble(),
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.grey,
                                      min: 0.0,
                                      max: currentSong!.length == "0"
                                          ? 0
                                          : double.parse(currentSong.length!) /
                                              1000,
                                      onChanged: (v) {
                                        musicControl.audioPlayer
                                            .seek(Duration(seconds: v.toInt()));
                                      });
                                }
                              },
                            ),
                            MusicControlButtonsWidget(
                              buttonSize: 50,
                            ),
                            SizedBox(
                              height: screenHeight(context) * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.volume_down,
                                  color: Colors.white,
                                ),
                                Consumer(
                                  builder: (BuildContext context,
                                          T Function<T>(
                                                  ProviderBase<Object?, T>)
                                              watch,
                                          Widget? child) =>
                                      Slider(
                                          value:
                                              watch(musicControlStateManagment)
                                                  .volume,
                                          activeColor: Colors.white,
                                          inactiveColor: Colors.grey,
                                          min: 0.0,
                                          max: 1,
                                          onChanged: (v) {
                                            VolumeController().setVolume(v);
                                          }),
                                ),
                                Icon(
                                  Icons.volume_up,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
