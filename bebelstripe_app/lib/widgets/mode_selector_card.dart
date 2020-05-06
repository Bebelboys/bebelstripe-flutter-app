import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/animated_music_spectrum_button.dart';
import '../providers/led_wall.dart';

class ModeSelectorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var ledWall = Provider.of<LedWall>(context);
    return Container(
      width: double.infinity,
      height: 100,
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.videogame_asset),
              onPressed: () {
                ledWall.setMode(LedWallMode.pong);
              },
            ),
            IconButton(
              icon: Icon(Icons.music_note),
              onPressed: () {
                ledWall.setMode(LedWallMode.musicSpectrum);
              },
            ),
            IconButton(
              icon: Icon(Icons.highlight),
              onPressed: () {
                ledWall.setMode(LedWallMode.stroboscope);
              },
            ),
          ],
        ),
      ),
    );
  }
}
