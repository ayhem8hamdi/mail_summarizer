import 'package:dartz/dartz.dart';
import 'package:inbox_iq/core/connection_checker.dart/network_info.dart';
import 'package:inbox_iq/core/failure/exceptions.dart';
import 'package:inbox_iq/core/failure/failure.dart';
import 'package:inbox_iq/features/home/data/remote/daily_summary_remote_data_source_repo.dart';
import 'package:inbox_iq/features/home/domain/entities/dailysummary_entity.dart';
import 'package:inbox_iq/features/home/domain/repo/home_repo.dart';

class DailySummaryRepositoryImpl implements DailySummaryRepository {
  final DailySummaryRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DailySummaryRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DailySummary>> getDailySummary() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteSummary = await remoteDataSource.getDailySummary();
        return Right(remoteSummary);
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
