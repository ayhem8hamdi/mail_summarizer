import 'package:inbox_iq/features/on_boarding/data/repo/on_boarding_repo.dart';

class CheckOnboardingStatusUseCase {
  final OnboardingRepository _repository;

  CheckOnboardingStatusUseCase(this._repository);

  Future<bool> call() async {
    return await _repository.isOnboardingCompleted();
  }
}
