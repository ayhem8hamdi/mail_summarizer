import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/features/inbox/presentation/widgets/inbox_details_body.dart';

class InboxDetailsView extends StatelessWidget {
  final String emailId;

  const InboxDetailsView({super.key, required this.emailId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Email',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0F172A),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF0F172A)),
            onPressed: () {
              // TODO: Show more options
            },
          ),
        ],
      ),
      body: InboxDetailsBody(emailId: emailId),
    );
  }
}
