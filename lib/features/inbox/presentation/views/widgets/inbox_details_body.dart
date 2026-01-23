import 'package:flutter/material.dart';
import 'package:inbox_iq/features/inbox/domain/entities/email_entity.dart';
import 'package:inbox_iq/features/inbox/presentation/views/widgets/email_action_buttons.dart';
import 'package:inbox_iq/features/inbox/presentation/views/widgets/email_body_content.dart';
import 'package:inbox_iq/features/inbox/presentation/views/widgets/email_details_header.dart';
import 'package:inbox_iq/features/voice_recording/presentation/views/voice_recorder_pop_up.dart';

class InboxDetailsBody extends StatelessWidget {
  final EmailEntity email;

  const InboxDetailsBody({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(_getPadding(context)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Email Header (Sender, Subject, Priority)
              EmailDetailHeader(email: email),

              // Email Body Content
              EmailBodyContent(body: email.snippet),

              // Divider line
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey.shade200,
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
                  // Show voice recording dialog
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const VoiceRecordingDialog(),
                  );
                },
              ),
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
