import 'package:inbox_iq/core/services/local_storage_service/local_storage_service.dart';
import 'package:inbox_iq/features/on_boarding/data/repo/on_boarding_repo.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  static const String _onboardingKey = 'is_onboarding_completed';
  final LocalStorageService _localStorageService;

  OnboardingRepositoryImpl(this._localStorageService);

  @override
  Future<bool> isOnboardingCompleted() async {
    return await _localStorageService.getBool(_onboardingKey);
  }

  @override
  Future<void> completeOnboarding() async {
    await _localStorageService.setBool(_onboardingKey, true);
  }
}
