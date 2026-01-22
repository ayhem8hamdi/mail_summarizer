enum MoodStatus {
  positive('Positive', '😊'),
  neutral('Neutral', '🤔'),
  urgent('Urgent', '😰');

  final String label;
  final String emoji;

  const MoodStatus(this.label, this.emoji);

  static MoodStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'positive':
        return MoodStatus.positive;
      case 'neutral':
        return MoodStatus.neutral;
      case 'urgent':
        return MoodStatus.urgent;
      default:
        return MoodStatus.neutral;
    }
  }
}
