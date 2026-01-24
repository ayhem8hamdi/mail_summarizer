// lib/features/home/data/repo/daily_summary_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:inbox_iq/core/connection_checker.dart/network_info.dart';
import 'package:inbox_iq/core/failure/exceptions.dart';
import 'package:inbox_iq/core/failure/failure.dart';
import 'package:inbox_iq/features/home/data/local_data_source.dart/daily_summary_local_data_source.dart';
import 'package:inbox_iq/features/home/data/remote_data_source/daily_summary_remote_data_source_repo.dart';

import 'package:inbox_iq/features/home/domain/entities/dailysummary_entity.dart';
import 'package:inbox_iq/features/home/domain/repo/home_repo.dart';

class DailySummaryRepositoryImpl implements DailySummaryRepository {
  final DailySummaryRemoteDataSource remoteDataSource;
  final DailySummaryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DailySummaryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DailySummary>> getDailySummary({
    bool forceRefresh = false,
  }) async {
    // If force refresh (swipe to refresh), skip cache and fetch from remote
    if (forceRefresh) {
      return _fetchFromRemote();
    }

    // Try to get cached data first (for initial load)
    try {
      final cachedSummary = await localDataSource.getCachedDailySummary();

      if (cachedSummary != null) {
        // Return cached data immediately
        return Right(cachedSummary);
      }
    } on CacheException catch (e) {
      // Log error but continue to fetch from remote
      print('Cache retrieval failed: ${e.message}');
    }

    // No cached data, fetch from remote
    return _fetchFromRemote();
  }

  Future<Either<Failure, DailySummary>> _fetchFromRemote() async {
    if (await networkInfo.isConnected) {
      try {
        // Fetch from remote
        final remoteSummary = await remoteDataSource.getDailySummary();

        // Cache the fresh data
        try {
          await localDataSource.cacheDailySummary(remoteSummary);
        } on CacheException catch (e) {
          // Log error but don't fail the request
          print('Failed to cache data: ${e.message}');
        }

        return Right(remoteSummary);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      } catch (e) {
        return Left(ServerFailure(message: 'Unexpected error occurred'));
      }
    } else {
      // No internet, try to return cached data as fallback
      try {
        final cachedSummary = await localDataSource.getCachedDailySummary();

        if (cachedSummary != null) {
          return Right(cachedSummary);
        }
      } on CacheException {
        // Ignore cache error, will return network failure
      }

      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> triggerWorkflow() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.triggerWorkflow();
        return Right(result);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      } catch (e) {
        return Left(ServerFailure(message: 'Unexpected error occurred'));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
