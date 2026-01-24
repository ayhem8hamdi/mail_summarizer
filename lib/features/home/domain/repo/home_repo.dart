// lib/features/home/domain/repo/home_repo.dart
import 'package:dartz/dartz.dart';
import 'package:inbox_iq/core/failure/failure.dart';
import 'package:inbox_iq/features/home/domain/entities/dailysummary_entity.dart';

abstract class DailySummaryRepository {
  Future<Either<Failure, DailySummary>> getDailySummary({
    bool forceRefresh = false,
  });

  Future<Either<Failure, bool>> triggerWorkflow();
}
