import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musicplayer/Logic/Control/MusicControl.dart';
import 'package:musicplayer/Logic/Misc/ScreenSize.dart';
import 'package:musicplayer/Logic/StateManagment/General/StateManagment.dart';

class CustomSliverAppBarWidget extends StatefulWidget {
  final Color appbarcolor;
  const CustomSliverAppBarWidget({Key? key, required this.appbarcolor})
      : super(key: key);

  @override
  _CustomSliverAppBarWidgetState createState() =>
      _CustomSliverAppBarWidgetState();
}

class _CustomSliverAppBarWidgetState extends State<CustomSliverAppBarWidget> {
  MusicControl _musicObject = MusicControl();
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        backgroundColor: widget.appbarcolor,
        pinned: true,
        leading: InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: screenWidth(context) * 0.02,
              ),
              Icon(
                Icons.arrow_back_ios,
                size: screenHeight(context) * 0.033,
                color: Colors.redAccent,
              ),
              Text(
                "Library",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: screenWidth(context) * 0.04,
                ),
              )
            ],
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PopupMenuButton(
              child: Text(
                "Sort",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: screenWidth(context) * 0.04,
                ),
              ),
              itemBuilder: (BuildContext context) {
                return [
                  ...Sort.values.map((e) => PopupMenuItem(
                        child: Text(e.name),
                        onTap: () {
                          _musicObject.sortList(
                              context: context, sortMethod: e);
                        },
                      ))
                ];
              },
            )
          ],
        ),
        centerTitle: true,
        leadingWidth: 105,
        toolbarHeight: 40,
        expandedHeight: screenHeight(context) * 0.18,
        flexibleSpace: LayoutBuilder(builder: (context, constrains) {
          Future.delayed(Duration.zero, () async {
            context
                .read(generalmanagment)
                .setoobacity(constrains.biggest.height);
          });
          return FlexibleSpaceBar(
            background: Container(
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: screenWidth(context) * 0.045,
                        bottom: screenHeight(context) * 0.01),
                    child: Text(
                      "Songs",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth(context) * 0.08,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: screenWidth(context) * 0.045,
                        right: screenWidth(context) * 0.045),
                    height: screenHeight(context) * 0.045,
                    child: TextField(
                      cursorColor: Colors.redAccent,
                      decoration: InputDecoration(
                        hintText: "Find in Songs",
                        hintStyle: TextStyle(color: Colors.white54),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white54,
                          size: screenWidth(context) * 0.055,
                        ),
                        prefixIconConstraints: BoxConstraints(
                            minWidth: screenWidth(context) * 0.08),
                        contentPadding: EdgeInsets.only(top: 1),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight(context) * 0.01,
                  )
                ],
              ),
            ),
          );
        }));
  }
}
