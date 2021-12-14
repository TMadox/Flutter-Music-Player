import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musicplayer/Presentation/Screens/SplashScreen.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (await Permission.storage.request().isGranted) {}
  runApp(ProviderScope(child: MaterialApp(home: SplashScreen())));
}
