import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title:Text('hello',style:TextStyle(fontWeight:FontWeight.bold,)),
      backgroundColor: Colors.blue,centerTitle: true,
      )
    );
  }
}
