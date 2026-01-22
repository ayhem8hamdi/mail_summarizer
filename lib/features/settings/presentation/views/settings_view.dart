import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/core/utils/app_styles.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.settings_rounded,
              size: 80,
              color: AppColors.kPrimaryBlue,
            ),
            const SizedBox(height: 16),
            Text('Settings Screen', style: AppStyles.bold24(context)),
            const SizedBox(height: 8),
            Text('Coming soon...', style: AppStyles.regular14(context)),
          ],
        ),
      ),
    );
  }
}
