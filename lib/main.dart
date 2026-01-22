import 'package:flutter/material.dart';
import 'package:inbox_iq/features/splash/presentation/views/splash_view.dart';

void main() {
  runApp(const InboxIq());
}

class InboxIq extends StatelessWidget {
  const InboxIq({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}
