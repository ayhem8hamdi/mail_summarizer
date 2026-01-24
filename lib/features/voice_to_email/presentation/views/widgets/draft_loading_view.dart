import 'package:flutter/material.dart';

class DraftLoadingView extends StatelessWidget {
  const DraftLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: Color(0xFF2563EB)),
          const SizedBox(height: 24),
          const Text(
            'Generating your email...',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'AI is analyzing your voice',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
