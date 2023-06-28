import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../model/vidio_model.dart';

class openvidio extends StatefulWidget {
  int num;

  openvidio(this.num);

  @override
  State<openvidio> createState() => _openvidioState();
}

class _openvidioState extends State<openvidio> {
  String? videoId;

  late YoutubePlayer youtubeplayer;

  late YoutubePlayerController _controller;

  late String id;

  @override
  void initState() {
    // TODO: implement initSt ate
    super.initState();
    final String url = '${urlv[widget.num]}';

    id = YoutubePlayer.convertUrlToId(url)!;
    _controller = YoutubePlayerController(initialVideoId: id);
    youtubeplayer = YoutubePlayer(
      controller: _controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (contex, snapshot) {
          return Scaffold(
            body: youtubeplayer,
          );
        },
      ),
    );
  }
}
