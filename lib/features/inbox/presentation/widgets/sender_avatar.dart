import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';

class SenderAvatar extends StatelessWidget {
  final String initial;
  final double size;

  const SenderAvatar({super.key, required this.initial, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppColors.kPrimaryBlue,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initial.toUpperCase(),
          style: TextStyle(
            fontSize: size * 0.45,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
