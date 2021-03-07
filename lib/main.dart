import 'package:flutter/material.dart';
// Screens
import './screens/home_screen.dart';
import './screens/most_duration.dart';
import './screens/today_calls.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.amber,
      ),
      home: HomeScreen(),
      routes: {
        MostDurationScreen.routeName: (ctx) => MostDurationScreen(),
        TodaysCallsScreen.routeName: (ctx) => TodaysCallsScreen(),
      },
    );
  }
}
