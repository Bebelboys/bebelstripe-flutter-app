import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flare_dart/actor.dart';

class AnimatedMusicSpectrumButton extends StatefulWidget {
  @override
  _AnimatedMusicSpectrumButtonState createState() =>
      _AnimatedMusicSpectrumButtonState();
}

class _AnimatedMusicSpectrumButtonState
    extends State<AnimatedMusicSpectrumButton> {
  bool _isOn = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isOn = !_isOn;
          });
        },
        child: FlareActor(
          'assets/animations/Music_Spectrum_Icon.flr',
          animation: _isOn ? 'playMusicSpectrum' : 'stopMusicSpectrum',
        ),
      ),
    );
  }
}
