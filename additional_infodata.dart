import 'package:flutter/material.dart';

class additional_info extends StatelessWidget {
  final IconData icon;
  final String leble;
  final String value;
  additional_info({
    super.key,
    required this.icon,
    required this.leble,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 40),
        Text(
          leble,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
