import 'package:dio/dio.dart';
import 'package:inbox_iq/core/failure/exceptions.dart';
import 'package:inbox_iq/features/home/data/models/daily_summary_model.dart';
import 'package:inbox_iq/features/home/data/remote_data_source/daily_summary_remote_data_source_repo.dart';

class DailySummaryRemoteDataSourceImpl implements DailySummaryRemoteDataSource {
  final Dio dio;
  final String webhookUrl;

  DailySummaryRemoteDataSourceImpl({
    required this.dio,
    required this.webhookUrl,
  });

  @override
  Future<DailySummaryModel> getDailySummary() async {
    try {
      // Call the n8n webhook endpoint that returns the last workflow result
      final response = await dio.get(
        webhookUrl,
        options: Options(
          headers: {'Content-Type': 'application/json'},
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        // n8n returns an array, we need the first element
        final data = response.data;

        // Handle if n8n returns array or single object
        final jsonData = data is List ? data.first : data;

        return DailySummaryModel.fromJson(jsonData as Map<String, dynamic>);
      } else {
        throw ServerException(
          message: 'Failed to fetch daily summary',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      // Handle different types of DioException
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw TimeoutException(message: 'Request timeout', details: e.message);
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(
          message: 'No internet connection',
          details: e.message,
        );
      } else {
        throw ServerException.fromDioError(e);
      }
    } catch (e) {
      throw ServerException(
        message: 'Unexpected error occurred',
        details: e.toString(),
      );
    }
  }

  @override
  Future<bool> triggerWorkflow() async {
    try {
      // Trigger the workflow by making a POST request
      final response = await dio.post(
        webhookUrl,
        options: Options(
          headers: {'Content-Type': 'application/json'},
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw ServerException(
          message: 'Failed to trigger workflow',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw TimeoutException(message: 'Request timeout', details: e.message);
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(
          message: 'No internet connection',
          details: e.message,
        );
      } else {
        throw ServerException.fromDioError(e);
      }
    } catch (e) {
      throw ServerException(
        message: 'Unexpected error occurred',
        details: e.toString(),
      );
    }
  }
}
