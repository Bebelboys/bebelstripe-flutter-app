import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/led_wall.dart';
import '../providers/pong.dart';

class PongControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      child: Card(
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                PongControlArrow(
                  icon: Icons.arrow_upward,
                  playerId: 'left_player',
                  movementDirection: 1,
                ),
                SizedBox(height: 10),
                PongControlArrow(
                  icon: Icons.arrow_downward,
                  playerId: 'left_player',
                  movementDirection: -1,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                PongControlArrow(
                  icon: Icons.arrow_upward,
                  playerId: 'right_player',
                  movementDirection: 1,
                ),
                SizedBox(height: 10),
                PongControlArrow(
                  icon: Icons.arrow_downward,
                  playerId: 'right_player',
                  movementDirection: -1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PongControlArrow extends StatelessWidget {
  final IconData icon;
  final String playerId;
  final int movementDirection;
  //inal Function callback;

  PongControlArrow({
    @required this.icon,
    @required this.playerId,
    @required this.movementDirection,
  });

  @override
  Widget build(BuildContext context) {
    var pongProvider = Provider.of<Pong>(context);

    void movePaddle(int movementDirection) {
      pongProvider.movePaddle(playerId, movementDirection);
    }

    return GestureDetector(
        child: Icon(icon),
        onTapDown: (_) => movePaddle(movementDirection),
        onTapCancel: () => movePaddle(0),
        onTapUp: (_) => movePaddle(0));
  }
}
