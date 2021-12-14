import 'package:flutter/cupertino.dart';
import 'package:musicplayer/Data/Models/songs_model.dart';
import 'package:musicplayer/Logic/StateManagment/Music/MusicControlState.dart';
import 'package:musicplayer/Logic/StateManagment/Music/MusicLibraryState.dart';
import 'package:musicplayer/Logic/StateManagment/Music/NowPlayingState.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum Sort { Title, Recent, Artist }

class MusicControl {
  Future<void> loadNewSong(
      {required Songmetadata song,
      required BuildContext context,
      required int songIndex,
      required List<Songmetadata> currentPlayList}) async {
    await context
        .read(musicControlStateManagment)
        .loadSong(song: song, context: context);
    await context
        .read(nowPlayingStateManagment)
        .setPlayingSong(song: song, index: songIndex);
    await context
        .read(musicLibraryStateManagment)
        .setCurrentPlaylist(input: currentPlayList);
  }

  Future<void> playSong({
    required BuildContext context,
  }) async {
    await context.read(musicControlStateManagment).playSong();
  }

  Future<void> pauseSong({
    required BuildContext context,
  }) async {
    await context.read(musicControlStateManagment).pauseSong();
  }

  void sortList(
      {required BuildContext context, required Sort sortMethod}) async {
    await context
        .read(musicLibraryStateManagment)
        .sortAllSongs(sortMethod: sortMethod);
  }
}
