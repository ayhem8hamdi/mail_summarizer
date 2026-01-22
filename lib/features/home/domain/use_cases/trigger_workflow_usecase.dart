import 'package:dartz/dartz.dart';
import 'package:inbox_iq/core/failure/failure.dart';
import 'package:inbox_iq/features/home/domain/repo/home_repo.dart';

class TriggerWorkflowUseCase {
  final DailySummaryRepository repository;

  TriggerWorkflowUseCase(this.repository);

  Future<Either<Failure, bool>> call() async {
    return await repository.triggerWorkflow();
  }
}
