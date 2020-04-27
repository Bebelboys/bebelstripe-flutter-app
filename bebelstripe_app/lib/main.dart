import 'package:bebelstripe_app/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/main_screen.dart';
import './providers/led_wall.dart';
import './providers/pong.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: LedWall(
            serverUrl: 'http://192.168.120.13',
          ),
        ),
        ChangeNotifierProvider.value(
          value: Pong(
            serverUrl: 'http://192.168.120.13',
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BebelStripe',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
        ),
        initialRoute: MainScreen.routeName,
        routes: {
          MainScreen.routeName: (context) => MainScreen(),
          SettingsScreen.routeName: (context) => SettingsScreen(),
        },
      ),
    );
  }
}
