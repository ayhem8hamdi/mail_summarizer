import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';

/// Enum for email sentiment/priority types
enum SentimentType {
  positive,
  neutral,
  urgent;

  /// Get the emoji representation
  String get emoji {
    switch (this) {
      case SentimentType.positive:
        return '😊';
      case SentimentType.neutral:
        return '🤔';
      case SentimentType.urgent:
        return '😰';
    }
  }

  /// Get the label text
  String get label {
    switch (this) {
      case SentimentType.positive:
        return 'Positive';
      case SentimentType.neutral:
        return 'Neutral';
      case SentimentType.urgent:
        return 'Urgent';
    }
  }

  /// Get the color
  Color get color {
    switch (this) {
      case SentimentType.positive:
        return AppColors.kPositiveGreen;
      case SentimentType.neutral:
        return AppColors.kNeutralYellow;
      case SentimentType.urgent:
        return AppColors.kUrgentRed;
    }
  }

  /// Get the gradient
  Gradient get gradient {
    switch (this) {
      case SentimentType.positive:
        return AppColors.kPositiveGradient;
      case SentimentType.neutral:
        return AppColors.kNeutralGradient;
      case SentimentType.urgent:
        return AppColors.kUrgentGradient;
    }
  }
}

/// Model class for sentiment statistics
class SentimentStats {
  final int positiveCount;
  final int neutralCount;
  final int urgentCount;

  const SentimentStats({
    required this.positiveCount,
    required this.neutralCount,
    required this.urgentCount,
  });

  int get total => positiveCount + neutralCount + urgentCount;

  double get positivePercentage =>
      total > 0 ? (positiveCount / total) * 100 : 0;

  double get neutralPercentage => total > 0 ? (neutralCount / total) * 100 : 0;

  double get urgentPercentage => total > 0 ? (urgentCount / total) * 100 : 0;

  /// Mock data for development
  static const SentimentStats mockData = SentimentStats(
    positiveCount: 1,
    neutralCount: 0,
    urgentCount: 4,
  );
}
