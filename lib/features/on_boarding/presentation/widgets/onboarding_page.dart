import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/core/utils/app_styles.dart';
import 'package:inbox_iq/core/utils/constants.dart';
import 'package:inbox_iq/features/on_boarding/data/models/on_boarding_page_model.dart';
import 'package:inbox_iq/features/on_boarding/presentation/widgets/emoji_display.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPageModel pageModel;

  const OnboardingPageWidget({super.key, required this.pageModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _getHorizontalPadding(context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmojiContainerWidget(emoji: pageModel.emoji),

          SizedBox(height: _getSpacingAfterEmoji(context)),

          Text(
            pageModel.title,
            style: AppStyles.bold28(context).copyWith(fontSize: 27),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: AppConstants.spacing16),

          // Description
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _getDescriptionPadding(context),
            ),
            child: Text(
              pageModel.description,
              style: AppStyles.regular12(
                context,
              ).copyWith(color: AppColors.kTextSecondary, height: 1.55),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  /// Get responsive horizontal padding
  double _getHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return 20.0;
    if (width < 600) return 24.0;
    return 32.0;
  }

  /// Get responsive spacing after emoji
  double _getSpacingAfterEmoji(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return 32.0;
    if (width < 600) return 40.0;
    return 48.0;
  }

  /// Get responsive description padding
  double _getDescriptionPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return 8.0;
    if (width < 600) return 16.0;
    return 24.0;
  }
}
