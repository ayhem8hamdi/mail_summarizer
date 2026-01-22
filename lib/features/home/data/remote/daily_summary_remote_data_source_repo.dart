import 'package:inbox_iq/features/home/data/models/daily_summary_model.dart';

abstract class DailySummaryRemoteDataSource {
  Future<DailySummaryModel> getDailySummary();

  Future<bool> triggerWorkflow();
}
