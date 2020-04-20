import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';

import '../providers/led_wall.dart';

enum PickableColors {
  primaryColor,
  secondaryColor,
}

class ColorPicker extends StatelessWidget {
  final String titleString;
  final String subtitleString;
  final PickableColors colorToPick;

  ColorPicker(
    this.titleString,
    this.subtitleString,
    this.colorToPick,
  );

  @override
  Widget build(BuildContext context) {
    var ledWall = Provider.of<LedWall>(context);

    Color color;
    String colorString;
    if (colorToPick == PickableColors.primaryColor) {
      color = ledWall.primaryColor;
      colorString = 'primaryColor';
    } else if (colorToPick == PickableColors.secondaryColor) {
      color = ledWall.secondaryColor;
      colorString = 'secondaryColor';
    } else {
      throw Exception('Invalid colorToPick');
    }

    return Container(
      width: double.infinity,
      height: 100,
      child: Center(
        child: Card(
          elevation: 10,
          child: ListTile(
            title: Text(titleString),
            subtitle: Text(subtitleString),
            trailing: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  child: AlertDialog(
                    content: MaterialColorPicker(
                      selectedColor: color,
                      allowShades: false,
                      onMainColorChange: (color) {
                        ledWall.setColor(color, colorString);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                );
              },
              child: CircleAvatar(
                backgroundColor: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
