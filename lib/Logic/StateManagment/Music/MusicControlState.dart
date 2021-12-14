import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musicplayer/Data/Models/songs_model.dart';
import 'package:musicplayer/Logic/StateManagment/Music/MusicLibraryState.dart';
import 'package:musicplayer/Logic/StateManagment/Music/NowPlayingState.dart';

final musicControlStateManagment =
    ChangeNotifierProvider<MusicControlState>((ref) => MusicControlState());

class MusicControlState extends ChangeNotifier {
  bool isPlaying = false;
  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  double volume = 0;

  Future<void> loadSong({
    required Songmetadata song,
    required BuildContext context,
  }) async {
    await audioPlayer.play(song.path!, isLocal: true);
    notifyListeners();
  }

  Future<void> playSong() async {
    await audioPlayer.resume();
    notifyListeners();
  }

  Future<void> pauseSong() async {
    await audioPlayer.pause();
    notifyListeners();
  }

  void playNextSong({required BuildContext context}) async {
    int playingSongIndex = context
        .read(musicLibraryStateManagment)
        .currentPlaylist
        .indexOf(context.read(nowPlayingStateManagment).playingSong!);
    int currentLibraryLength =
        context.read(musicLibraryStateManagment).currentPlaylist.length;
    if (playingSongIndex != currentLibraryLength - 1) {
      loadSong(
          song: context
              .read(musicLibraryStateManagment)
              .currentPlaylist[playingSongIndex + 1],
          context: context);
    } else if (playingSongIndex == currentLibraryLength - 1) {
      loadSong(
          song: context.read(musicLibraryStateManagment).currentPlaylist[0],
          context: context);
    }
  }

  void setVolume(double input) {
    volume = input;
    notifyListeners();
  }
}
