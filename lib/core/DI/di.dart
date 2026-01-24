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
import 'package:inbox_iq/features/inbox/data/remote/inbox_remote_data_source.dart';
import 'package:inbox_iq/features/inbox/data/remote/inbox_remote_data_source_impl.dart';
import 'package:inbox_iq/features/inbox/data/repo/inbox_repo_impl.dart';
import 'package:inbox_iq/features/inbox/domain/repos/inbox_repostry.dart';
import 'package:inbox_iq/features/inbox/domain/usecases/filtered_emails_usecase.dart';
import 'package:inbox_iq/features/inbox/domain/usecases/get_email_by_id_usecase.dart';
import 'package:inbox_iq/features/inbox/domain/usecases/get_emails_use_case.dart';
import 'package:inbox_iq/features/voice_to_email/data/remote/voice_to_email_remote_data_source.dart';
import 'package:inbox_iq/features/voice_to_email/data/remote/voice_to_email_remote_data_source_impl.dart';
import 'package:inbox_iq/features/voice_to_email/data/repo/voice_to_email_repo_impl.dart';
import 'package:inbox_iq/features/voice_to_email/domain/repo/voice_to_email_repo.dart';
import 'package:inbox_iq/features/voice_to_email/domain/usecase/generate_email_from_voice_usecase.dart';
import 'package:inbox_iq/features/voice_to_email/domain/usecase/send_email_use_case.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/manager/email_draft_cubit/email_draft_cubit.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/manager/voice_recorder_cubit/voice_recorder_cubit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! =========================
  //! External Dependencies
  //! =========================
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(),
  );

  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    if (sl<AppConfig>().isDebugMode) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true, error: true),
      );
    }

    return dio;
  });

  //! =========================
  //! Core
  //! =========================
  sl.registerLazySingleton<AppConfig>(() => AppConfig());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! =========================
  //! Feature: Home
  //! =========================
  // Data sources
  sl.registerLazySingleton<DailySummaryRemoteDataSource>(
    () => DailySummaryRemoteDataSourceImpl(
      dio: sl(),
      webhookUrl: sl<AppConfig>().n8nWebhookUrlDailySummary,
    ),
  );

  // Repository
  sl.registerLazySingleton<DailySummaryRepository>(
    () => DailySummaryRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetDailySummaryUseCase(sl()));
  sl.registerLazySingleton(() => TriggerWorkflowUseCase(sl()));

  //! =========================
  //! Feature: Inbox
  //! =========================
  // Data sources
  sl.registerLazySingleton<InboxRemoteDataSource>(
    () => InboxRemoteDataSourceImpl(
      dio: sl(),
      webhookUrl: sl<AppConfig>().n8nWebhookUrlInbox,
    ),
  );

  // Repository
  sl.registerLazySingleton<InboxRepository>(
    () => InboxRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetEmailsUseCase(sl()));
  sl.registerLazySingleton(() => GetFilteredEmailsUseCase(sl()));
  sl.registerLazySingleton(() => GetEmailByIdUseCase(sl()));

  //! =========================
  //! Feature: Voice Email (Refactored)
  //! =========================
  // Data sources
  sl.registerLazySingleton<VoiceEmailRemoteDataSource>(
    () => VoiceEmailRemoteDataSourceImpl(
      dio: sl(),
      webhookUrl: sl<AppConfig>().n8nWebhookUrlVoiceToMail,
      sendEmailWebhookUrl: sl<AppConfig>().n8nWebhookUrlSendEmail,
    ),
  );

  // Repository
  sl.registerLazySingleton<VoiceEmailRepository>(
    () => VoiceEmailRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GenerateEmailFromVoiceUseCase(sl()));
  sl.registerLazySingleton(() => SendEmailUseCase(sl()));

  // Cubits (Factory - new instance each time)
  sl.registerFactory(() => VoiceRecorderCubit());
  sl.registerFactory(
    () => EmailDraftCubit(
      generateEmailFromVoiceUseCase: sl(),
      sendEmailUseCase: sl(),
    ),
  );
}
