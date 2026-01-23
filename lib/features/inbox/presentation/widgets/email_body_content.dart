import 'package:flutter/material.dart';

class EmailBodyContent extends StatelessWidget {
  final String body;

  const EmailBodyContent({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Text(
        body,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF1E293B),
          height: 1.6,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
