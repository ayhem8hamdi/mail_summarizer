import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox_iq/features/inbox/domain/usecases/filtered_emails_usecase.dart';
import 'package:inbox_iq/features/inbox/domain/usecases/get_emails_use_case.dart';
import 'package:inbox_iq/features/inbox/presentation/manager/inbox_cubit/inbox_cubit_states.dart';

class InboxCubit extends Cubit<InboxState> {
  final GetEmailsUseCase getEmailsUseCase;
  final GetFilteredEmailsUseCase getFilteredEmailsUseCase;

  InboxCubit({
    required this.getEmailsUseCase,
    required this.getFilteredEmailsUseCase,
  }) : super(InboxInitial());

  String _currentFilter = 'All';

  Future<void> fetchEmails() async {
    emit(InboxLoading());

    final result = await getEmailsUseCase();

    result.fold(
      (failure) => emit(
        InboxError(message: failure.userMessage, details: failure.details),
      ),
      (emails) =>
          emit(InboxLoaded(emails: emails, currentFilter: _currentFilter)),
    );
  }

  Future<void> refreshEmails() async {
    if (state is InboxLoaded) {
      final currentState = state as InboxLoaded;
      emit(
        InboxRefreshing(
          currentEmails: currentState.emails,
          currentFilter: currentState.currentFilter,
        ),
      );
    } else {
      emit(InboxLoading());
    }

    final result = await getEmailsUseCase();

    result.fold(
      (failure) => emit(
        InboxError(message: failure.userMessage, details: failure.details),
      ),
      (emails) =>
          emit(InboxLoaded(emails: emails, currentFilter: _currentFilter)),
    );
  }

  void changeFilter(String filter) {
    if (state is InboxLoaded) {
      _currentFilter = filter;
      final currentState = state as InboxLoaded;

      emit(InboxLoaded(emails: currentState.emails, currentFilter: filter));
    }
  }

  String get currentFilter => _currentFilter;
}
