import 'package:dartz/dartz.dart';
import 'package:inbox_iq/core/connection_checker.dart/network_info.dart';
import 'package:inbox_iq/core/failure/exceptions.dart';
import 'package:inbox_iq/core/failure/failure.dart';
import 'package:inbox_iq/features/inbox/data/remote/inbox_remote_data_source.dart';
import 'package:inbox_iq/features/inbox/domain/entities/email_entity.dart';
import 'package:inbox_iq/features/inbox/domain/repos/inbox_repostry.dart';

class InboxRepositoryImpl implements InboxRepository {
  final InboxRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  InboxRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<EmailEntity>>> getEmails() async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final emails = await remoteDataSource.getEmails();
      return Right(emails);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on NetworkException catch (e) {
      return Left(NetworkFailure.fromException(e));
    } catch (e) {
      return Left(
        UnexpectedFailure(
          message: 'Failed to fetch emails',
          details: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<EmailEntity>>> getFilteredEmails(
    String filter,
  ) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final emails = await remoteDataSource.getEmails();

      // Filter emails based on priority
      List<EmailEntity> filteredEmails;
      switch (filter.toLowerCase()) {
        case 'urgent':
          filteredEmails = emails
              .where((e) => e.priority == EmailPriority.urgent)
              .toList();
          break;
        case 'action required':
          filteredEmails = emails
              .where((e) => e.priority == EmailPriority.action)
              .toList();
          break;
        case 'fyi':
          filteredEmails = emails
              .where((e) => e.priority == EmailPriority.fyi)
              .toList();
          break;
        default:
          filteredEmails = emails;
      }

      return Right(filteredEmails);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on NetworkException catch (e) {
      return Left(NetworkFailure.fromException(e));
    } catch (e) {
      return Left(
        UnexpectedFailure(
          message: 'Failed to filter emails',
          details: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, EmailEntity>> getEmailById(String emailId) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final email = await remoteDataSource.getEmailById(emailId);
      return Right(email);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on NetworkException catch (e) {
      return Left(NetworkFailure.fromException(e));
    } catch (e) {
      return Left(
        UnexpectedFailure(
          message: 'Failed to fetch email details',
          details: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> markAsRead(String emailId) async {
    // TODO: Implement when backend supports it
    return const Right(true);
  }
}
