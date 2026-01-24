import 'package:flutter/material.dart';

class RecordingHeader extends StatelessWidget {
  final VoidCallback? onClose;

  const RecordingHeader({super.key, this.onClose});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: onClose,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(onClose != null ? 0.2 : 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close,
              color: Colors.white.withOpacity(onClose != null ? 1.0 : 0.5),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
