// lib/features/home/domain/use_cases/get_daily_summary_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:inbox_iq/core/failure/failure.dart';
import 'package:inbox_iq/features/home/domain/entities/dailysummary_entity.dart';
import 'package:inbox_iq/features/home/domain/repo/home_repo.dart';

class GetDailySummaryUseCase {
  final DailySummaryRepository repository;

  GetDailySummaryUseCase(this.repository);

  Future<Either<Failure, DailySummary>> call({
    bool forceRefresh = false,
  }) async {
    return await repository.getDailySummary(forceRefresh: forceRefresh);
  }
}
