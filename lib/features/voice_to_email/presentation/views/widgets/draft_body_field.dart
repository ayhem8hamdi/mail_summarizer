import 'package:flutter/material.dart';

class DraftBodyField extends StatelessWidget {
  final TextEditingController controller;
  final bool isEnabled;

  const DraftBodyField({
    super.key,
    required this.controller,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 300, minHeight: 200),
        decoration: BoxDecoration(
          color: isEnabled ? Colors.white : Colors.grey.shade50,
          border: Border.all(
            color: isEnabled ? const Color(0xFF2563EB) : Colors.grey.shade300,
            width: isEnabled ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: controller,
          enabled: isEnabled,
          maxLines: null,
          style: const TextStyle(
            fontSize: 14,
            height: 1.6,
            color: Color(0xFF0F172A),
          ),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(16),
            border: InputBorder.none,
            hintText: 'Type your message...',
          ),
        ),
      ),
    );
  }
}
