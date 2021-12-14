import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musicplayer/Logic/StateManagment/Music/MusicControlState.dart';

class MusicControlButtonsWidget extends StatefulWidget {
  final double? buttonSize;
  const MusicControlButtonsWidget({Key? key, this.buttonSize})
      : super(key: key);

  @override
  _MusicControlButtonsWidgetState createState() =>
      _MusicControlButtonsWidgetState();
}

class _MusicControlButtonsWidgetState extends State<MusicControlButtonsWidget> {
  @override
  Widget build(BuildContext context) {
    final musicControl = context.read(musicControlStateManagment);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.skip_previous,
              color: Colors.white,
              size: widget.buttonSize,
            )),
        StreamBuilder(
          initialData: musicControl.audioPlayer.state,
          stream: musicControl.audioPlayer.onPlayerStateChanged,
          builder: (BuildContext context, AsyncSnapshot<PlayerState> snapshot) {
            switch (snapshot.data) {
              case null:
                return IconButton(
                    onPressed: () {
                      musicControl.playSong();
                    },
                    icon: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: widget.buttonSize,
                    ));
              case PlayerState.STOPPED:
                return IconButton(
                    onPressed: () {
                      musicControl.playSong();
                    },
                    icon: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: widget.buttonSize,
                    ));
              case PlayerState.PLAYING:
                return IconButton(
                    onPressed: () {
                      musicControl.pauseSong();
                    },
                    icon: Icon(
                      Icons.pause,
                      color: Colors.white,
                      size: widget.buttonSize,
                    ));

              case PlayerState.PAUSED:
                return IconButton(
                    onPressed: () {
                      musicControl.playSong();
                    },
                    icon: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: widget.buttonSize,
                    ));
              case PlayerState.COMPLETED:
                return IconButton(
                    onPressed: () {
                      musicControl.playSong();
                    },
                    icon: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: widget.buttonSize,
                    ));
            }
          },
        ),
        IconButton(
            onPressed: () {
              musicControl.playNextSong(context: context);
            },
            icon: Icon(
              Icons.skip_next,
              color: Colors.white,
              size: widget.buttonSize,
            )),
      ],
    );
  }
}
