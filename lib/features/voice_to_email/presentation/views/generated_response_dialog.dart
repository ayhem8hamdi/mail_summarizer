import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/manager/email_draft_cubit/email_draft_cubit.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/manager/email_draft_cubit/email_draft_states.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/views/widgets/draft_dialog_content.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/views/widgets/draft_loading_view.dart';

class GeneratedResponseDialog extends StatelessWidget {
  const GeneratedResponseDialog({super.key});

  void _handleClose(BuildContext context) {
    Navigator.of(context).pop();
    context.read<EmailDraftCubit>().reset();
  }

  void _showSuccessMessage(BuildContext context) {
    Navigator.of(context).pop();
    context.read<EmailDraftCubit>().reset();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email sent successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmailDraftCubit, EmailDraftState>(
      listener: (context, state) {
        if (state is EmailDraftSent) {
          _showSuccessMessage(context);
        } else if (state is EmailDraftSendFailed) {
          _showErrorMessage(context, state.message);
        }
      },
      child: BlocBuilder<EmailDraftCubit, EmailDraftState>(
        builder: (context, state) {
          if (state is EmailDraftSuccess ||
              state is EmailDraftSending ||
              state is EmailDraftSendFailed) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: DraftDialogContent(onClose: () => _handleClose(context)),
            );
          }

          return const Dialog(
            backgroundColor: Colors.transparent,
            child: DraftLoadingView(),
          );
        },
      ),
    );
  }
}
