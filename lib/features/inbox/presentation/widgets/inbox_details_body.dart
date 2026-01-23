import 'package:flutter/material.dart';
import 'package:inbox_iq/features/inbox/data/email_details_entity.dart';
import 'package:inbox_iq/features/inbox/presentation/widgets/email_body_content.dart';
import 'package:inbox_iq/features/inbox/presentation/widgets/email_action_buttons.dart';
import 'package:inbox_iq/features/inbox/presentation/widgets/email_details_header.dart';

class InboxDetailsBody extends StatelessWidget {
  final String emailId;

  const InboxDetailsBody({super.key, required this.emailId});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with real data from Cubit/BLoC
    final email = mockEmailDetail;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(_getPadding(context)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 22,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              // Email Header (Sender, Subject, Priority)
              EmailDetailHeader(email: email),

              // Email Body Content
              EmailBodyContent(body: email.body),

              // Divider line
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  height: 0.8,
                  thickness: 0.6,
                  color: Colors.grey.shade400,
                ),
              ),

              // Action Buttons
              EmailActionButtons(
                onReply: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Reply feature coming soon'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                onVoiceReply: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Voice reply feature coming soon'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  double _getPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return 12.0;
    if (width < 600) return 16.0;
    return 20.0;
  }
}
