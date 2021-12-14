import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musicplayer/Data/Models/songs_model.dart';

final generalmanagment = ChangeNotifierProvider<General>((ref) => General());

class General extends ChangeNotifier {
  late double obacity;
  late Songmetadata playedsong;
  void setoobacity(double value) {
    obacity = value;
    notifyListeners();
  }
}
