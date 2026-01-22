import 'package:flutter/material.dart';

class EmojiContainerWidget extends StatelessWidget {
  final String emoji;

  const EmojiContainerWidget({super.key, required this.emoji});

  @override
  Widget build(BuildContext context) {
    final containerSize = _getContainerSize(context);
    final emojiSize = MediaQuery.sizeOf(context).width * 0.33;

    return SizedBox(
      width: containerSize,
      height: containerSize,
      child: Center(
        child: Text(emoji, style: TextStyle(fontSize: emojiSize, height: 1.0)),
      ),
    );
  }

  double _getContainerSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return 140.0;
    if (width < 600) return 160.0;
    return 180.0;
  }
}
