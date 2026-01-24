import 'package:equatable/equatable.dart';
import 'package:inbox_iq/features/voice_to_email/domain/entities/voice_to_email_response_entity.dart';

abstract class EmailDraftState extends Equatable {
  const EmailDraftState();

  @override
  List<Object?> get props => [];
}

class EmailDraftInitial extends EmailDraftState {
  const EmailDraftInitial();
}

class EmailDraftGenerating extends EmailDraftState {
  const EmailDraftGenerating();
}

class EmailDraftSuccess extends EmailDraftState {
  final VoiceEmailResponseEntity response;

  const EmailDraftSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class EmailDraftError extends EmailDraftState {
  final String message;

  const EmailDraftError({required this.message});

  @override
  List<Object?> get props => [message];
}

class EmailDraftSending extends EmailDraftState {
  const EmailDraftSending();
}

class EmailDraftSent extends EmailDraftState {
  const EmailDraftSent();
}

class EmailDraftSendFailed extends EmailDraftState {
  final String message;

  const EmailDraftSendFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
