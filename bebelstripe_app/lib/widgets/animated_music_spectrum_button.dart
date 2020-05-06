// import 'package:flare_flutter/flare_actor.dart';
// import 'package:flutter/material.dart';
// import 'package:flare_dart/actor.dart';
// import 'package:provider/provider.dart';

// import '../providers/led_wall.dart';

// class AnimatedMusicSpectrumButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var ledWall = Provider.of<LedWall>(context);
//     return Container(
//       height: 30,
//       width: double.infinity,
//       child: GestureDetector(
//         onTap: () {
//           ledWall.setMode(LedWallMode.musicSpectrum);
//         },
//         child: FlareActor(
//           'assets/animations/Music_Spectrum_Icon.flr',
//           animation: ledWall.mode == LedWallMode.musicSpectrum
//               ? 'playMusicSpectrum'
//               : 'idleMusicSpectrum',
//         ),
//       ),
//     );
//   }
// }
