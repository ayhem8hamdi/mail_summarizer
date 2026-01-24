import 'dart:math' as math;
import 'package:flutter/material.dart';

class AudioWavePainter extends CustomPainter {
  final double animation;
  final Color color;

  AudioWavePainter({required this.animation, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    const barCount = 50;
    final barWidth = size.width / barCount;

    for (int i = 0; i < barCount; i++) {
      final x = i * barWidth + barWidth / 2;

      final heightFactor = math.sin(
        (i / barCount * math.pi * 4) + (animation * math.pi * 2),
      );
      final randomFactor = math.sin(i * 0.5 + animation * 3);
      final height =
          (size.height / 2) *
          (0.3 + (heightFactor * 0.4) + (randomFactor * 0.3));

      canvas.drawLine(
        Offset(x, size.height / 2 - height),
        Offset(x, size.height / 2 + height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(AudioWavePainter oldDelegate) => true;
}
