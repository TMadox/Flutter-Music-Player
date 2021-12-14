import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageCheckWidget {
  Widget checkImage({String? input}) {
    if (input == null) {
      return Image.asset(
        "Assets/MusicPlaceHolder.png",
        fit: BoxFit.fill,
      );
    } else {
      return FadeInImage(
          fit: BoxFit.fill,
          placeholder: MemoryImage(kTransparentImage),
          image: MemoryImage(
            base64Decode(input),
          ));
    }
  }
}
