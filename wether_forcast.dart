import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  final String time;
  final String value;
  final IconData icon;
  const HourlyForecast({
    super.key,
    required this.icon,
    required this.time,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        color: Colors.blue,
        child: Container(
          width: 100,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                time,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Icon(icon, size: 40),
              Text(value),
            ],
          ),
        ),
      ),
    );
  }
}
