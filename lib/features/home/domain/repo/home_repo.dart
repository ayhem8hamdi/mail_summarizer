import 'package:dartz/dartz.dart';
import 'package:inbox_iq/core/failure/failure.dart';
import 'package:inbox_iq/features/home/domain/entities/dailysummary_entity.dart';

abstract class DailySummaryRepository {
  Future<Either<Failure, DailySummary>> getDailySummary();

  Future<Either<Failure, bool>> triggerWorkflow();
}
