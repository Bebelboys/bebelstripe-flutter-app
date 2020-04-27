import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/led_wall.dart';

class BrightnessSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var ledWall = Provider.of<LedWall>(context);
    return Container(
      width: double.infinity,
      height: 100,
      child: Card(
        elevation: 5,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 10),
              Text(
                  'Chosen brightness: ${ledWall.brightnessInPercent.toStringAsFixed(2)}'),
              Expanded(
                child: Slider(
                  value: ledWall.brightnessInPercent,
                  min: 0.0,
                  max: 100.0,
                  onChanged: (newVal) => ledWall.setBrightness(newVal),
                  label: 'Brightness',
                  activeColor: Colors.red,
                  inactiveColor: Colors.black,
                ),
              ),
            ]),
      ),
    );
  }
}
