import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musicplayer/Data/Models/songs_model.dart';

final nowPlayingStateManagment =
    ChangeNotifierProvider<NowPlayingState>((ref) => NowPlayingState());

class NowPlayingState extends ChangeNotifier {
  Songmetadata? playingSong = Songmetadata(
      title: "",
      artist: "",
      track: "",
      album: "",
      discNumber: "",
      beatsPerMinute: "",
      year: "",
      length: "0",
      albumArtist: "",
      image: null,
      path: "",
      dateAdded: DateTime.now().toString());

  int playingSongIndex = 0;

  Future<void> setPlayingSong(
      {required Songmetadata song, required int index}) async {
    playingSong = song;
    playingSongIndex = index;
    notifyListeners();
  }
}
