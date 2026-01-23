import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:inbox_iq/core/DI/di.dart' as di;
import 'package:inbox_iq/core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(DevicePreview(enabled: true, builder: (context) => const InboxIq()));
}

class InboxIq extends StatelessWidget {
  const InboxIq({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
