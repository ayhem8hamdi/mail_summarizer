import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_styles.dart';
import 'package:inbox_iq/core/utils/constants.dart';

class StatItem extends StatelessWidget {
  final IconData icon;
  final int count;
  final String label;

  const StatItem({
    super.key,
    required this.icon,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 15),
        ),
        SizedBox(width: AppConstants.spacing4),
        Text(
          '$count $label',
          style: AppStyles.regular12(
            context,
          ).copyWith(color: Colors.white, fontSize: 10),
        ),
      ],
    );
  }
}
