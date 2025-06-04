import 'package:flutter/material.dart';

class HourlyforcastCard extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temp;
  const HourlyforcastCard({
    super.key,
    required this.time,
    required this.icon,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 120,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                time,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Icon(icon, size: 25),
              SizedBox(height: 8),
              Text(temp, style: TextStyle(fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }
}
