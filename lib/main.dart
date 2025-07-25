import 'package:flutter/material.dart';
import 'package:myapp/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:WeatherPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),

    );
  }
}
