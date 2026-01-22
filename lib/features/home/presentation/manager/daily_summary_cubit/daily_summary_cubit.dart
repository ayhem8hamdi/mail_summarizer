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

  /// Fetch daily summary from n8n
  Future<void> fetchDailySummary() async {
    emit(DailySummaryLoading());

    final result = await getDailySummaryUseCase();

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

  /// Refresh daily summary (pull to refresh)
  Future<void> refreshDailySummary() async {
    // If we already have data, show it while refreshing
    if (state is DailySummaryLoaded) {
      final currentSummary = (state as DailySummaryLoaded).summary;
      emit(DailySummaryRefreshing(currentSummary));
    } else {
      emit(DailySummaryLoading());
    }

    final result = await getDailySummaryUseCase();

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
        emit(
          DailySummaryError(
            message: 'Failed to trigger workflow: ${failure.userMessage}',
            details: failure.details,
          ),
        );
      },
      (success) async {
        // Wait a bit for the workflow to complete
        await Future.delayed(const Duration(seconds: 2));

        // Then fetch the result
        final fetchResult = await getDailySummaryUseCase();

        fetchResult.fold(
          (failure) => emit(
            DailySummaryError(
              message: failure.userMessage,
              details: failure.details,
            ),
          ),
          (summary) => emit(DailySummaryLoaded(summary)),
        );
      },
    );
  }
}
