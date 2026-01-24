import 'package:inbox_iq/features/home/data/models/daily_summary_model.dart';

abstract class DailySummaryLocalDataSource {
  Future<DailySummaryModel?> getCachedDailySummary();
  Future<void> cacheDailySummary(DailySummaryModel summary);
  Future<void> clearCache();
}
