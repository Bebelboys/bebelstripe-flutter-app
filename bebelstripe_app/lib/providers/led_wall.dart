import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum LedWallMode {
  musicSpectrum,
  stroboscope,
  ambient,
  pong,
}

final Map<LedWallMode, String> ledWallModeEnumToString = {
  LedWallMode.musicSpectrum: "music",
  LedWallMode.stroboscope: "strobo",
  LedWallMode.pong: "pong",
};

final Map<String, LedWallMode> ledWallModeStringToEnum =
    ledWallModeEnumToString.map((k, v) => MapEntry(v, k));

List<int> colorToRGBIntList(Color color) =>
    [color.red, color.green, color.blue];

Map<String, String> httpJsonHeaders = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

class LedWall with ChangeNotifier {
  String _serverUrl;
  bool _initComplete = false;
  bool _on;
  LedWallMode _mode;
  double _brightnessInPercent;
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.red;
  bool _fallingDot;
  List<int> _fftWeights;
  double _stroboFrequency;
  double _stroboDutyCycle;
  bool _ambientPulsing;
  double _ambientFrequency;

  bool get initComplete => _initComplete;
  double get brightnessInPercent => _brightnessInPercent;
  Color get primaryColor => _primaryColor;
  Color get secondaryColor => _secondaryColor;
  LedWallMode get mode => _mode;

  LedWall({
    @required String serverUrl,
  }) {
    this._serverUrl = serverUrl;

    fetchAllSettings().then((_) {
      _initComplete = true;
      notifyListeners();
    }).catchError((error) {
      throw error;
    });
  }

  Future<void> fetchAllSettings() async {
    try {
      var settingsResponse = await http.get('$_serverUrl/settings');
      var controlResponse = await http.get('$_serverUrl/control');
      var settings = json.decode(settingsResponse.body);
      var control = json.decode(controlResponse.body);

      _on = control['on'];
      String modeString = control['mode'];
      LedWallMode modeEnum = ledWallModeStringToEnum[modeString];
      switch (modeEnum) {
        case LedWallMode.musicSpectrum:
          {
            _mode = LedWallMode.musicSpectrum;
          }
          break;

        case LedWallMode.stroboscope:
          {
            _mode = LedWallMode.stroboscope;
          }
          break;
        case LedWallMode.pong:
          {
            _mode = LedWallMode.pong;
          }
          break;
        default:
          {
            throw Exception('Invalid mode of LedWall: ${control['on']}');
          }
          break;
      }

      _brightnessInPercent = 100 * settings['general']['brightness'];

      _primaryColor = Color.fromRGBO(
        settings['color']['primaryColor'][0],
        settings['color']['primaryColor'][1],
        settings['color']['primaryColor'][2],
        1.0,
      );
      _secondaryColor = Color.fromRGBO(
        settings['color']['secondaryColor'][0],
        settings['color']['secondaryColor'][1],
        settings['color']['secondaryColor'][2],
        1.0,
      );

      _fallingDot = settings['music']['fallingDot'];
      _fftWeights = settings['music']['fftWeightings'].cast<int>();

      _stroboFrequency = settings['strobo']['frequency'];
      _stroboDutyCycle = settings['strobo']['dutyCycle'];

      _ambientPulsing = settings['ambient']['pulsing'];
      _ambientFrequency = settings['ambient']['frequency'];

      _initComplete = true;
    } catch (error) {
      throw error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> setBrightness(double newBrightnessInPercent) async {
    var oldValue = _brightnessInPercent;
    print('New brightness: $newBrightnessInPercent %');

    _brightnessInPercent = newBrightnessInPercent;
    notifyListeners();

    try {
      var response = await http.put(
        '$_serverUrl/settings',
        headers: httpJsonHeaders,
        body: json.encode(
          {
            "general": {"brightness": newBrightnessInPercent / 100},
          },
        ),
      );
      if (response.statusCode > 400) {
        print('An error occured during setBrightness');
        throw Exception('Status code > 400');
      }
    } catch (error) {
      _brightnessInPercent = oldValue;
      notifyListeners();
      print('Error in setBrightness: ${error.toString()}');
      throw error;
    }
  }

  Future<void> setColor(Color newColor, String colorType) async {
    // TODO: implement optimistic updating
    if (colorType == 'primaryColor') {
      _primaryColor = newColor;
    } else if (colorType == 'secondaryColor') {
      _secondaryColor = newColor;
    } else {
      throw Exception(
          'Invalid color type: $colorType. Must be either primaryColor or secondaryColor');
    }
    try {
      var response = await http.put(
        '$_serverUrl/settings',
        headers: httpJsonHeaders,
        body: json.encode(
          {
            'color': {colorType: colorToRGBIntList(newColor)},
          },
        ),
      );
      if (response.statusCode > 400) {
        print('An error occured during setColor');
        throw Exception('Status code > 400');
      }
    } catch (error) {
      throw error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> setMode(LedWallMode mode) async {
    // TODO: implement optimistic updating
    try {
      var response = await http.put(
        '$_serverUrl/control',
        headers: httpJsonHeaders,
        body: json.encode(
          {
            'mode': ledWallModeEnumToString[mode],
          },
        ),
      );
      if (response.statusCode > 400) {
        print('An error occured during setMode');
        throw Exception('Status code > 400');
      }
      _mode = ledWallModeStringToEnum[json.decode(response.body)['mode']];
    } catch (error) {
      throw error;
    } finally {
      notifyListeners();
    }
  }
}
