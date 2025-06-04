import 'package:flutter/material.dart';

class AddOns extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AddOns({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: 120,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(icon, size: 25),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
