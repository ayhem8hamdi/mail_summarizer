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

  /// Fetch all emails from API
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

  /// Refresh emails (pull to refresh)
  Future<void> refreshEmails() async {
    // If we already have data, show it while refreshing
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

  /// Change filter (All, Urgent, Action Required, FYI)
  void changeFilter(String filter) {
    if (state is InboxLoaded) {
      _currentFilter = filter;
      final currentState = state as InboxLoaded;

      // Just update the filter, no API call needed
      emit(InboxLoaded(emails: currentState.emails, currentFilter: filter));
    }
  }

  /// Get current filter
  String get currentFilter => _currentFilter;
}
