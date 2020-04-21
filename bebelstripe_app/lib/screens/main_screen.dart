import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';

import './settings_screen.dart';
import '../widgets/mode_selector_card.dart';
import '../widgets/color_picker.dart';
import '../widgets/brightness_slider.dart';
import '../widgets/animated_music_spectrum_button.dart';
import '../providers/led_wall.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/';
  int sliderValue = 0;

  @override
  Widget build(BuildContext context) {
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
      body: !Provider.of<LedWall>(context).initComplete
          ? Center(
              child: SizedBox(
                  width: 100, height: 100, child: CircularProgressIndicator()))
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ModeSelectorCard(),
                  SizedBox(height: 100),
                  GestureDetector(
                    child: Icon(Icons.power_settings_new, size: 100),
                    onTap: () {},
                  ),
                  ColorPicker('Level color', 'Color of the bars',
                      PickableColors.primaryColor),
                  ColorPicker('Dot color', 'Color of the dot',
                      PickableColors.secondaryColor),
                  BrightnessSlider(),
                ],
              ),
            ),
    );
  }
}
