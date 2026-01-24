import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox_iq/features/voice_to_email/domain/entities/voice_to_email_draft_entity.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/manager/email_draft_cubit/email_draft_cubit.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/manager/email_draft_cubit/email_draft_states.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/views/widgets/draft_actions_button.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/views/widgets/draft_body_field.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/views/widgets/draft_header.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/views/widgets/draft_receipent_field.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/views/widgets/draft_subject_field.dart';

class DraftDialogContent extends StatefulWidget {
  final VoidCallback onClose;
  const DraftDialogContent({super.key, required this.onClose});
  @override
  State<DraftDialogContent> createState() => _DraftDialogContentState();
}

class _DraftDialogContentState extends State<DraftDialogContent> {
  late TextEditingController _emailController;
  late TextEditingController _subjectController;
  late TextEditingController _bodyController;
  bool _isEditMode = false;
  VoiceEmailDraftEntity? _currentDraft;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _subjectController = TextEditingController();
    _bodyController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _updateControllers(VoiceEmailDraftEntity draft) {
    if (_currentDraft != null) return;
    _currentDraft = draft;
    _emailController.text = draft.to;
    _subjectController.text = draft.subject;
    _bodyController.text = draft.body;
  }

  void _handleSendEmail(BuildContext context) {
    if (_currentDraft == null) return;
    const userId = 'test_user_123'; // TODO: Get from auth

    context.read<EmailDraftCubit>().sendEmail(
      to: _emailController.text.trim(),
      subject: _subjectController.text.trim(),
      body: _bodyController.text.trim(),
      userId: userId,
    );
  }

  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailDraftCubit, EmailDraftState>(
      builder: (context, state) {
        if (state is EmailDraftSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _updateControllers(state.response.draft);
          });
        }
        final isLoading = state is EmailDraftSending;

        return Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 450),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DraftHeader(onClose: isLoading ? null : widget.onClose),
              DraftRecipientField(
                controller: _emailController,
                isEnabled: _isEditMode && !isLoading,
              ),
              DraftSubjectField(
                controller: _subjectController,
                isEnabled: _isEditMode && !isLoading,
              ),
              DraftBodyField(
                controller: _bodyController,
                isEnabled: _isEditMode && !isLoading,
              ),
              DraftActionButtons(
                isEditMode: _isEditMode,
                isLoading: isLoading,
                onToggleEdit: _toggleEditMode,
                onSend: () => _handleSendEmail(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
