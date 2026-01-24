import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox_iq/features/inbox/domain/entities/email_entity.dart';
import 'package:inbox_iq/features/inbox/presentation/views/widgets/email_action_buttons.dart';
import 'package:inbox_iq/features/inbox/presentation/views/widgets/email_body_content.dart';
import 'package:inbox_iq/features/inbox/presentation/views/widgets/email_details_header.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/manager/email_draft_cubit/email_draft_cubit.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/manager/voice_recorder_cubit/voice_recorder_cubit.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/views/voice_recorder_dialog.dart';

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
              EmailDetailHeader(email: email),
              EmailBodyContent(body: email.snippet),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey.shade200,
                ),
              ),
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
                  // Get existing cubit instances from parent context
                  final voiceRecorderCubit = context.read<VoiceRecorderCubit>();
                  final emailDraftCubit = context.read<EmailDraftCubit>();

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (dialogContext) => MultiBlocProvider(
                      providers: [
                        // Pass existing instances to dialog
                        BlocProvider.value(value: voiceRecorderCubit),
                        BlocProvider.value(value: emailDraftCubit),
                      ],
                      child: const VoiceRecordingDialog(
                        userId: 'test_user_123', // TODO: Get from auth
                      ),
                    ),
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
