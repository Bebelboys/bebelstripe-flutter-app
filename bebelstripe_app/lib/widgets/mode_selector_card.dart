import 'package:flutter/material.dart';

class ModeSelectorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: <Widget>[
            Text('Select mode'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.music_note),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.gavel),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.highlight),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.ac_unit),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
