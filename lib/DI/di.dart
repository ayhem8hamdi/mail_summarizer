import 'package:dio/dio.dart';
import 'package:inbox_iq/core/failure/failure.dart';
import 'package:inbox_iq/features/home/data/remote/daily_summary_remote_data_source_repo.dart';
import 'package:inbox_iq/features/home/data/remote/daily_summary_remote_data_source_repo_impl.dart';
import 'package:inbox_iq/features/home/data/repo/daily_summary_repo_impl.dart';
import 'package:inbox_iq/features/home/domain/repo/home_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Home
  // Cubit - Register as factory so each screen gets fresh instance

  // Repository
  sl.registerLazySingleton<DailySummaryRepository>(
    () => DailySummaryRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<DailySummaryRemoteDataSource>(
    () => DailySummaryRemoteDataSourceImpl(
      dio: sl(),
      webhookUrl: sl<AppConfig>().n8nWebhookUrl,
    ),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());

  // Dio
  sl.registerLazySingleton(() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Add interceptors for logging (only in debug mode)
    if (sl<AppConfig>().isDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: false,
        ),
      );
    }

    return dio;
  });

  // App Configuration - Must be registered first
  sl.registerLazySingleton(() => AppConfig());
}

// lib/core/config/app_config.dart
class AppConfig {
  // n8n webhook URL - Replace with your actual webhook URL
  // IMPORTANT: In production, use environment variables or secure storage
  final String n8nWebhookUrl = const String.fromEnvironment(
    'N8N_WEBHOOK_URL',
    defaultValue: 'https://your-n8n-instance.com/webhook/daily-summary',
  );

  final bool isDebugMode = const bool.fromEnvironment(
    'DEBUG_MODE',
    defaultValue: true,
  );
}
