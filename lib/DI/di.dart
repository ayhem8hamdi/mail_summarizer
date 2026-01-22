import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:inbox_iq/core/config/app_config.dart';
import 'package:inbox_iq/core/connection_checker.dart/network_info.dart';
import 'package:inbox_iq/features/home/data/remote/daily_summary_remote_data_source_repo.dart';
import 'package:inbox_iq/features/home/data/remote/daily_summary_remote_data_source_repo_impl.dart';
import 'package:inbox_iq/features/home/data/repo/daily_summary_repo_impl.dart';
import 'package:inbox_iq/features/home/domain/repo/home_repo.dart';
import 'package:inbox_iq/features/home/domain/use_cases/get_daily_summary_usecase.dart';
import 'package:inbox_iq/features/home/domain/use_cases/trigger_workflow_usecase.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Home

  // Use Cases
  sl.registerLazySingleton(() => GetDailySummaryUseCase(sl()));
  sl.registerLazySingleton(() => TriggerWorkflowUseCase(sl()));

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
  sl.registerLazySingleton(() => AppConfig());

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
}
