// lib/features/home/presentation/manager/daily_summary_cubit/daily_summary_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox_iq/features/home/domain/use_cases/get_daily_summary_usecase.dart';
import 'package:inbox_iq/features/home/domain/use_cases/trigger_workflow_usecase.dart';
import 'package:inbox_iq/features/home/presentation/manager/daily_summary_cubit/daily_summary_cubit_states.dart';

class DailySummaryCubit extends Cubit<DailySummaryState> {
  final GetDailySummaryUseCase getDailySummaryUseCase;
  final TriggerWorkflowUseCase triggerWorkflowUseCase;

  DailySummaryCubit({
    required this.getDailySummaryUseCase,
    required this.triggerWorkflowUseCase,
  }) : super(DailySummaryInitial());

  /// Fetch daily summary (initial load - uses cache first, then fetches if empty)
  Future<void> fetchDailySummary() async {
    emit(DailySummaryLoading());

    // forceRefresh = false means it will try cache first
    final result = await getDailySummaryUseCase(forceRefresh: false);

    result.fold(
      (failure) => emit(
        DailySummaryError(
          message: failure.userMessage,
          details: failure.details,
        ),
      ),
      (summary) => emit(DailySummaryLoaded(summary)),
    );
  }

  /// Refresh daily summary (pull to refresh - always fetches from API)
  Future<void> refreshDailySummary() async {
    // If we already have data, show it while refreshing
    if (state is DailySummaryLoaded) {
      final currentSummary = (state as DailySummaryLoaded).summary;
      emit(DailySummaryRefreshing(currentSummary));
    } else {
      emit(DailySummaryLoading());
    }

    // forceRefresh = true means it will skip cache and fetch from API
    final result = await getDailySummaryUseCase(forceRefresh: true);

    result.fold((failure) {
      // If refresh fails but we have cached data, keep showing it
      if (state is DailySummaryRefreshing) {
        final currentSummary = (state as DailySummaryRefreshing).currentSummary;
        emit(DailySummaryLoaded(currentSummary));
        // Optionally, you could show a snackbar here to notify user
      } else {
        emit(
          DailySummaryError(
            message: failure.userMessage,
            details: failure.details,
          ),
        );
      }
    }, (summary) => emit(DailySummaryLoaded(summary)));
  }

  /// Trigger n8n workflow manually and then fetch the result
  Future<void> triggerAndFetch() async {
    if (state is DailySummaryLoaded) {
      final currentSummary = (state as DailySummaryLoaded).summary;
      emit(DailySummaryRefreshing(currentSummary));
    } else {
      emit(DailySummaryLoading());
    }

    // First, trigger the workflow
    final triggerResult = await triggerWorkflowUseCase();

    await triggerResult.fold(
      (failure) async {
        // If trigger fails but we have cached data, restore it
        if (state is DailySummaryRefreshing) {
          final currentSummary =
              (state as DailySummaryRefreshing).currentSummary;
          emit(DailySummaryLoaded(currentSummary));
        } else {
          emit(
            DailySummaryError(
              message: 'Failed to trigger workflow: ${failure.userMessage}',
              details: failure.details,
            ),
          );
        }
      },
      (success) async {
        // Wait a bit for the workflow to complete
        await Future.delayed(const Duration(seconds: 2));

        // Then fetch the result (force refresh to get latest data)
        final fetchResult = await getDailySummaryUseCase(forceRefresh: true);

        fetchResult.fold((failure) {
          // If fetch fails after trigger, restore cached data if available
          if (state is DailySummaryRefreshing) {
            final currentSummary =
                (state as DailySummaryRefreshing).currentSummary;
            emit(DailySummaryLoaded(currentSummary));
          } else {
            emit(
              DailySummaryError(
                message: failure.userMessage,
                details: failure.details,
              ),
            );
          }
        }, (summary) => emit(DailySummaryLoaded(summary)));
      },
    );
  }
}
