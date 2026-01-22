import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_images.dart';
import 'package:inbox_iq/core/utils/app_styles.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.splashLogoPng,
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.width * 0.27,
          fit: BoxFit.scaleDown,
        ),
        const SizedBox(height: 5),
        Text(
          'InboxlQ',
          style: AppStyles.bold20(context).copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 9),

        Text(
          'Al-Powered Email Intelligence',
          style: AppStyles.regular12(context).copyWith(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
