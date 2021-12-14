import 'package:flutter/material.dart';
import 'package:musicplayer/Data/Constants/Variables.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.black,
        actions: [
          Center(
            child: TextButton(
                onPressed: () {},
                child: Text(
                  "Edit",
                  style: TextStyle(color: Colors.redAccent),
                )),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Container(
          child: ListView(
        children: ListTile.divideTiles(
                context: context,
                tiles: libraryhomelist
                    .map((e) => ListTile(
                          leading: Icon(
                            Icons.warning,
                            color: Colors.redAccent,
                          ),
                          title: Text(
                            e,
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                    .toList())
            .toList(),
      )),
    );
  }
}
