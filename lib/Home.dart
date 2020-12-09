import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioPlayer audioPlayer = new AudioPlayer();
  Duration duration = new Duration();
  Duration position = new Duration();
  bool playing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Center(
            child: Container(
              //  width: 250,
              child: Row(
                children: [
                  // Text(duration.inMinutes.toDouble().toString()),
                  Text(position.inMinutes.toString() +
                      ":" +
                      position.inSeconds.toString()),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "widget.username",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .apply(color: Colors.black),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.73,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(41, 15, 102, 20),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(100, 100, 100, 0.5),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  getAudio();
                                },
                                child: Icon(
                                  playing == false
                                      ? Icons.play_arrow
                                      : Icons.pause,
                                  size: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Slider.adaptive(
                                min: 0.0,
                                value: position.inSeconds.toDouble(),
                                max: duration.inSeconds.toDouble(),
                                onChanged: (double value) {
                                  setState(() {
                                    audioPlayer.seek(
                                        new Duration(seconds: value.toInt()));
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      " widget.date",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .apply(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  void getAudio() async {
    var url =
        "https://erpdemo.dkatia.com/cg/uploads/messages/83c38c1e6f38eca76b051c9420b660dfd3.mp3";
    //playing is false defualt
    if (playing) {
      //puase song
      var res = await audioPlayer.pause();
      if (res == 1) {
        setState(() {
          playing = false;
        });
      }
    } else {
      //play song
      var res = await audioPlayer.play(url, isLocal: true);
      if (res == 1) {
        setState(() {
          playing = true;
        });
      }
    }
    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((Duration d) {
      setState(() {
        position = d;
      });
    });
  }
}
