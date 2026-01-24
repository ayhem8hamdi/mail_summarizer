import 'package:flutter/material.dart';

class DraftSubjectField extends StatelessWidget {
  final TextEditingController controller;
  final bool isEnabled;

  const DraftSubjectField({
    super.key,
    required this.controller,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        children: [
          const Text(
            'Subject:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              enabled: isEnabled,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF0F172A),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: 'Email subject',
                hintStyle: TextStyle(color: Colors.grey.shade400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
