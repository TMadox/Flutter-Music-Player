import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musicplayer/Logic/Control/MusicControl.dart';
import 'package:musicplayer/Logic/StateManagment/Music/MusicLibraryState.dart';
import 'package:musicplayer/Logic/StateManagment/Music/NowPlayingState.dart';
import 'package:musicplayer/Presentation/Widgets/CustomSliverAppBar.dart';
import 'package:musicplayer/Presentation/Widgets/ImageCheckWidget.dart';
import 'package:musicplayer/Presentation/Widgets/NowPlayingWidget.dart';

class SongsScreen extends StatefulWidget {
  @override
  _SongsScreenState createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {
  ScrollController _scrollController = ScrollController();
  MusicControl _musicObject = MusicControl();
  ImageCheckWidget _imageCheck = ImageCheckWidget();
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(onPressed: () {
        // _musicObject.storeDataLocally(songsList: context.read(musicLibraryStateManagment).allSongs);
      }),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              CustomSliverAppBarWidget(appbarcolor: Colors.black),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => Consumer(
                          builder: (BuildContext context,
                              T Function<T>(ProviderBase<Object?, T>) watch,
                              Widget? child) {
                            final musicLibrary =
                                watch(musicLibraryStateManagment);
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: musicLibrary.allSongs.length + 1,
                              itemBuilder: (BuildContext context, int index) {
                                if (index == musicLibrary.allSongs.length) {
                                  return Card(
                                    child: ListTile(),
                                    color: Colors.black,
                                  );
                                }
                                return Card(
                                  color: Colors.black,
                                  child: ListTile(
                                    dense: true,
                                    onTap: () async {
                                      _musicObject.loadNewSong(
                                          song: musicLibrary.allSongs[index],
                                          context: context,
                                          songIndex: index,
                                          currentPlayList:
                                              musicLibrary.allSongs);
                                    },
                                    leading: _imageCheck.checkImage(
                                        input:
                                            musicLibrary.allSongs[index].image),
                                    title: Text(
                                      textCheck(
                                          input: musicLibrary
                                              .allSongs[index].title),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      textCheck(
                                          input: musicLibrary
                                              .allSongs[index].artist),
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                    trailing: IconButton(
                                        icon: Icon(Icons.more_horiz),
                                        color: Colors.white,
                                        onPressed: () {}),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                    childCount: 1),
              ),
            ],
          ),
          Consumer(
              builder: (BuildContext context,
                      T Function<T>(ProviderBase<Object?, T>) watch,
                      Widget? child) =>
                  NowPlayingWidget(
                    playingSong: watch(nowPlayingStateManagment).playingSong!,
                  ))
        ],
      ),
    );
  }

  String textCheck({String? input}) {
    if (input == null) {
      return " ";
    } else {
      return input;
    }
  }

  imageCheck() {}
}
