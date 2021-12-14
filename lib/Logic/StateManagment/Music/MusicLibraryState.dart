import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musicplayer/Data/Models/songs_model.dart';
import 'package:musicplayer/Logic/Control/MusicControl.dart';

final musicLibraryStateManagment =
    ChangeNotifierProvider<MusicLibraryState>((ref) => MusicLibraryState());

class MusicLibraryState extends ChangeNotifier {
  List<Songmetadata> allSongs = [];
  List<Songmetadata> currentPlaylist = [];

  setAllSongs({required List<Songmetadata> input}) async {
    allSongs = input;
  }

  setCurrentPlaylist({required List<Songmetadata> input}) {
    currentPlaylist = input;
  }

  sortAllSongs({required Sort sortMethod}) {
    switch (sortMethod) {
      case Sort.Title:
        {
          allSongs.sort((a, b) => a.title.toString()
              .toLowerCase()
              .compareTo(b.title.toString().toLowerCase()));
          notifyListeners();
        }
        break;
      case Sort.Artist:
        {
          allSongs.sort((a, b) => a.artist.toString()
              .toLowerCase()
              .compareTo(b.artist.toString().toLowerCase()));
          notifyListeners();
        }
        break;
      case Sort.Recent:
        {
          allSongs.sort((a, b) => a.dateAdded
              .toString()
              .toLowerCase()
              .compareTo(b.dateAdded.toString().toLowerCase()));
          notifyListeners();
        }
        break;
    }
  }
}
