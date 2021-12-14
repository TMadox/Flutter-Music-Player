import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:id3/id3.dart';
import 'package:musicplayer/Data/Models/songs_model.dart';
import 'package:musicplayer/Logic/StateManagment/Music/MusicLibraryState.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReadMusic {
  List<Songmetadata> songsinfo = [];

  Future<void> loadFiles({required BuildContext context}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("songs")) {
      String? storedList = prefs.getString("songs");
      List decodedList = json.decode(storedList!);
      List<Songmetadata> currentList =
          await getAllFiles(showHidden: true, context: context);
    } else {
      getAllFiles(context: context, showHidden: true);
    }
  }

  Future<void> storeDataLocally({required List<Songmetadata> songsList}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("songs") == false) {
      List<Map<String, dynamic>> temp = [];
      songsList.forEach((element) {
        temp.add(element.toMap());
      });
      String encodedList = json.encode(temp);
      await prefs.setString('songs', encodedList);
    }
  }

  Future<List<Songmetadata>> getAllFiles(
      {required bool showHidden, required BuildContext context}) async {
    songsinfo = [];
    List<Directory> storages = await getStorageList();
    List<FileSystemEntity> files = <FileSystemEntity>[];
    for (Directory dir in storages) {
      List<FileSystemEntity> allFilesInPath = [];
      try {
        allFilesInPath = await getAllFilesInPath(dir.path, showHidden: true);
      } catch (e) {
        allFilesInPath = [];
      }
      files.addAll(allFilesInPath);
    }
    context.read(musicLibraryStateManagment).setAllSongs(input: songsinfo);
    return songsinfo;
  }

  Future<List<Directory>> getStorageList() async {
    List<Directory>? paths = await getExternalStorageDirectories();
    List<Directory> filteredPaths = <Directory>[];
    for (Directory dir in paths!) {
      filteredPaths.add(removeDataDirectory(dir.path));
    }
    return filteredPaths;
  }

  Directory removeDataDirectory(String path) {
    return Directory(path.split("Android")[0]);
  }

  Future<List<FileSystemEntity>> getAllFilesInPath(String path,
      {required bool showHidden}) async {
    List<FileSystemEntity> files = <FileSystemEntity>[];
    Directory d = Directory(path);
    List<FileSystemEntity> l = d.listSync();
    for (FileSystemEntity file in l) {
      if (FileSystemEntity.isFileSync(file.path)) {
        if (!showHidden) {
          if (!basename(file.path).startsWith(".")) {
            File f = new File(file.path);
            List<int> mp3Bytes = f.readAsBytesSync();
            MP3Instance mp3instance = new MP3Instance(mp3Bytes);
            Map<String, dynamic> item = mp3instance.getMetaTags()!;
            item.addAll(
                {"path": file.path, "dateAdded": DateTime.now().toString()});
            if (mp3instance.parseTagsSync()) {
              songsinfo.add(Songmetadata.fromMap(item));
            }
            files.add(file);
          }
        } else {
          if (file.path.contains(".mp3")) {
            File f = new File(file.path);
            List<int> mp3Bytes = f.readAsBytesSync();
            MP3Instance mp3instance = new MP3Instance(mp3Bytes);
            Map<String, dynamic> item = mp3instance.getMetaTags()!;
            item.addAll(
                {"path": file.path, "dateAdded": DateTime.now().toString()});
            if (mp3instance.parseTagsSync()) {
              songsinfo.add(Songmetadata.fromMap(item));
            }
            files.add(file);
          }
        }
      } else {
        if (!file.path.contains("/storage/emulated/0/Android")) {
          if (!showHidden) {
            if (!basename(file.path).startsWith(".")) {
              files.addAll(
                  await getAllFilesInPath(file.path, showHidden: showHidden));
            }
          } else {
            files.addAll(
                await getAllFilesInPath(file.path, showHidden: showHidden));
          }
        }
      }
    }
    return files;
  }
}
