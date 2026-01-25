// lib/features/inbox/presentation/manager/inbox_cubit/inbox_cubit.dart
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

  /// Initial fetch - will use cache if available, otherwise fetch from API
  Future<void> fetchEmails() async {
    emit(InboxLoading());

    // Use cache if available (forceRefresh: false)
    final result = await getEmailsUseCase(forceRefresh: false);

    result.fold(
      (failure) => emit(
        InboxError(message: failure.userMessage, details: failure.details),
      ),
      (emails) =>
          emit(InboxLoaded(emails: emails, currentFilter: _currentFilter)),
    );
  }

  /// Refresh emails - always fetches from API and updates cache (called on pull-to-refresh)
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

    // FORCE REFRESH from remote API (forceRefresh: true)
    final result = await getEmailsUseCase(forceRefresh: true);

    result.fold(
      (failure) {
        // If refresh fails but we have current emails, keep showing them
        if (state is InboxRefreshing) {
          final refreshingState = state as InboxRefreshing;
          emit(
            InboxLoaded(
              emails: refreshingState.currentEmails,
              currentFilter: refreshingState.currentFilter,
            ),
          );
        } else {
          emit(
            InboxError(message: failure.userMessage, details: failure.details),
          );
        }
      },
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
