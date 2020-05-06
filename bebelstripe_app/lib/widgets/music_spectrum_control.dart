import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import './color_picker.dart';
import './brightness_slider.dart';

class MusicSpectrumControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Container(
          width: double.infinity,
          height: 150,
          child: FlareActor('assets/animations/Music_Spectrum_Icon.flr',
              animation: 'playMusicSpectrum'),
        ),
        ColorPicker(
            'Level color', 'Color of the bars', PickableColors.primaryColor),
        ColorPicker(
            'Dot color', 'Color of the dot', PickableColors.secondaryColor),
        BrightnessSlider(),
      ]),
    );
  }
}
