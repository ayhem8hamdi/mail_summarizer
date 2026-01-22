import 'package:equatable/equatable.dart';
import 'package:inbox_iq/features/home/domain/entities/dailysummary_entity.dart';

abstract class DailySummaryState extends Equatable {
  const DailySummaryState();

  @override
  List<Object?> get props => [];
}

// Initial state
class DailySummaryInitial extends DailySummaryState {}

// Loading state
class DailySummaryLoading extends DailySummaryState {}

// Success state
class DailySummaryLoaded extends DailySummaryState {
  final DailySummary summary;

  const DailySummaryLoaded(this.summary);

  @override
  List<Object?> get props => [summary];
}

// Error state
class DailySummaryError extends DailySummaryState {
  final String message;
  final String? details;

  const DailySummaryError({required this.message, this.details});

  @override
  List<Object?> get props => [message, details];
}

// Refreshing state (when pulling to refresh)
class DailySummaryRefreshing extends DailySummaryState {
  final DailySummary currentSummary;

  const DailySummaryRefreshing(this.currentSummary);

  @override
  List<Object?> get props => [currentSummary];
}
