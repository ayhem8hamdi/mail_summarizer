import 'package:flutter/material.dart';

class MicrophoneAnimation extends StatefulWidget {
  const MicrophoneAnimation({super.key});

  @override
  State<MicrophoneAnimation> createState() => _MicrophoneAnimationState();
}

class _MicrophoneAnimationState extends State<MicrophoneAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [..._buildPulseRings(), _buildMicrophoneIcon()],
        );
      },
    );
  }

  List<Widget> _buildPulseRings() {
    return List.generate(3, (i) {
      return Transform.scale(
        scale: 1.0 + (_pulseController.value * 0.3 * (i + 1)),
        child: Container(
          width: 120 + (i * 20),
          height: 120 + (i * 20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(
                0.3 - (_pulseController.value * 0.3 * (i + 1) / 3),
              ),
              width: 2,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildMicrophoneIcon() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const Icon(Icons.mic, size: 48, color: Colors.white),
    );
  }
}
