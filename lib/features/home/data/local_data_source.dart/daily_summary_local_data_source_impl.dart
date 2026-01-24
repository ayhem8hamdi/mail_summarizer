// lib/features/home/data/local/daily_summary_local_data_source_impl.dart
import 'package:hive/hive.dart';
import 'package:inbox_iq/core/failure/exceptions.dart';
import 'package:inbox_iq/features/home/data/local_data_source.dart/daily_summary_local_data_source.dart';
import 'package:inbox_iq/features/home/data/models/daily_summary_model.dart';

class DailySummaryLocalDataSourceImpl implements DailySummaryLocalDataSource {
  static const String _boxName = 'daily_summary_box';
  static const String _summaryKey = 'cached_daily_summary';

  final HiveInterface hive;

  DailySummaryLocalDataSourceImpl({required this.hive});

  @override
  Future<DailySummaryModel?> getCachedDailySummary() async {
    try {
      final box = await hive.openBox<DailySummaryModel>(_boxName);
      return box.get(_summaryKey);
    } catch (e) {
      throw CacheException(
        message: 'Failed to retrieve cached data',
        details: e.toString(),
      );
    }
  }

  @override
  Future<void> cacheDailySummary(DailySummaryModel summary) async {
    try {
      final box = await hive.openBox<DailySummaryModel>(_boxName);
      await box.put(_summaryKey, summary);
    } catch (e) {
      throw CacheException(
        message: 'Failed to cache data',
        details: e.toString(),
      );
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      final box = await hive.openBox<DailySummaryModel>(_boxName);
      await box.clear();
    } catch (e) {
      throw CacheException(
        message: 'Failed to clear cache',
        details: e.toString(),
      );
    }
  }
}
