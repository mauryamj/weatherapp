import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/hourly_forcast.dart';
import 'package:myapp/addition_content.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=093aff067964ac6f532da7f3e87b0c6c',
        ),
      );
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'An unexpected error occured';
      }
      return data;
      //  temp = data['list'][0]['main']['temp']
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final data = snapshot.data! as Map;
          final currentdata = data['list'][0];
          final currentTemp = currentdata['main']['temp'];
          final currentSky = currentdata['weather'][0]['main'];
          final currentPressure = currentdata['main']['pressure'];
          final currentHumidity = currentdata['main']['humidity'];
          final currentWindSpeed = currentdata['wind']['speed'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //maincard
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            '$currentTemp k',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                          ),
                          Icon(
                            currentSky == 'Clouds' || currentSky == 'Rain'
                                ? Icons.cloud
                                : Icons.sunny,
                            size: 64,
                          ),
                          Text(
                            '$currentSky',
                            style: const TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Weather Forecast",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(height: 16),
                //waetherforcast card
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 1; i < 6; i++)
                        HourlyforcastCard(
                          time: DateFormat.j().format(
                            DateTime.parse(data['list'][i]['dt_txt']),
                          ),
                          // Suggested code may be subject to a license. Learn more: ~LicenseLog:2400643146.
                          icon:
                              data['list'][i]['weather'][0]['main'] ==
                                          'Clouds' ||
                                      data['list'][i]['weather'][0]['main'] ==
                                          'Rain'
                                  ? Icons.cloud
                                  : Icons.sunny,
                          temp: data['list'][i]['main']['temp'].toString(),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                //others card
                Text(
                  " Adittional Info",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Row(children: [
                  
                ],
              ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      AddOns(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: '$currentHumidity',
                      ),
                      AddOns(
                        icon: Icons.air,
                        label: 'Wind Speed',
                        value: '$currentWindSpeed',
                      ),
                      AddOns(
                        icon: Icons.umbrella,
                        label: 'Pressure',
                        value: '$currentPressure',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
