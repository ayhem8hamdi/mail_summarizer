import 'package:flutter/material.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/views/widgets/audio_waves_painter.dart';

class AudioWaveVisualization extends StatefulWidget {
  const AudioWaveVisualization({super.key});

  @override
  State<AudioWaveVisualization> createState() => _AudioWaveVisualizationState();
}

class _AudioWaveVisualizationState extends State<AudioWaveVisualization>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: AnimatedBuilder(
        animation: _waveController,
        builder: (context, child) {
          return CustomPaint(
            size: const Size(double.infinity, 80),
            painter: AudioWavePainter(
              animation: _waveController.value,
              color: Colors.white.withOpacity(0.6),
            ),
          );
        },
      ),
    );
  }
}
