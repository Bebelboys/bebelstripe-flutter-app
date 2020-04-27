import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Map<String, String> httpJsonHeaders = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

class Pong with ChangeNotifier {
  String _serverEndpointUrl;

  Pong({@required String serverUrl}) {
    _serverEndpointUrl = '$serverUrl/pong';
  }

  Future<void> movePaddle(String playerId, int movementDirection) async {
    try {
      var response = await http.put(
        _serverEndpointUrl,
        headers: httpJsonHeaders,
        body: json.encode({
          playerId: {
            'paddle': {'y_velocity': movementDirection},
          }
        }),
      );
      if (response.statusCode > 400) {
        print('An error occured during movePaddle');
        throw Exception('Status code > 400');
      }
    } catch (error) {
      throw error;
    }
  }
}
