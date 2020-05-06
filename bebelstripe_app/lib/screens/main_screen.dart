import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';

import './settings_screen.dart';
import '../widgets/mode_selector_card.dart';
import '../widgets/music_spectrum_control.dart';
import '../widgets/pong_control.dart';
import '../providers/led_wall.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/';
  int sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    var ledWall = Provider.of<LedWall>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () =>
                Navigator.of(context).pushNamed(SettingsScreen.routeName),
          ),
        ],
        title: Text('BebelStripe'),
      ),
      body: !ledWall.initComplete
          ? Center(
              child: SizedBox(
                  width: 100, height: 100, child: CircularProgressIndicator()))
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ModeSelectorCard(),
                  SizedBox(height: 25),
                  if (ledWall.mode == LedWallMode.musicSpectrum)
                    MusicSpectrumControl(),
                  if (ledWall.mode == LedWallMode.pong) PongControl(),
                ],
              ),
            ),
    );
  }
}
