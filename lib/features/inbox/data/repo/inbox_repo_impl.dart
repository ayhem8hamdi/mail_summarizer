// lib/features/inbox/data/repo/inbox_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:inbox_iq/core/connection_checker.dart/network_info.dart';
import 'package:inbox_iq/core/failure/exceptions.dart';
import 'package:inbox_iq/core/failure/failure.dart';
import 'package:inbox_iq/features/inbox/data/local_data_source/inbox_local_data_source.dart';
import 'package:inbox_iq/features/inbox/data/remote_data_source/inbox_remote_data_source.dart';
import 'package:inbox_iq/features/inbox/domain/entities/email_entity.dart';
import 'package:inbox_iq/features/inbox/domain/repos/inbox_repostry.dart';

class InboxRepositoryImpl implements InboxRepository {
  final InboxRemoteDataSource remoteDataSource;
  final InboxLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  InboxRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<EmailEntity>>> getEmails({
    bool forceRefresh = false,
  }) async {
    // If force refresh (pull-to-refresh), skip cache and fetch from remote
    if (forceRefresh) {
      return _fetchFromRemote();
    }

    // Try to get cached data first (for initial load)
    try {
      final cachedEmails = await localDataSource.getCachedEmails();

      if (cachedEmails != null && cachedEmails.isNotEmpty) {
        // Return cached data immediately
        return Right(cachedEmails);
      }
    } on CacheException catch (e) {
      // Log error but continue to fetch from remote
      print('Cache retrieval failed: ${e.message}');
    }

    // No cached data, fetch from remote
    return _fetchFromRemote();
  }

  Future<Either<Failure, List<EmailEntity>>> _fetchFromRemote() async {
    if (await networkInfo.isConnected) {
      try {
        // Fetch from remote
        final remoteEmails = await remoteDataSource.getEmails();

        // Cache the fresh data
        try {
          await localDataSource.cacheEmails(remoteEmails);
        } on CacheException catch (e) {
          // Log error but don't fail the request
          print('Failed to cache emails: ${e.message}');
        }

        return Right(remoteEmails);
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
        final cachedEmails = await localDataSource.getCachedEmails();

        if (cachedEmails != null && cachedEmails.isNotEmpty) {
          return Right(cachedEmails);
        }
      } on CacheException {
        // Ignore cache error, will return network failure
      }

      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<EmailEntity>>> getFilteredEmails(
    String filter,
  ) async {
    try {
      // Get all emails from cache first
      final cachedEmails = await localDataSource.getCachedEmails();

      if (cachedEmails != null && cachedEmails.isNotEmpty) {
        // Filter locally
        final filteredEmails = _filterEmailsByPriority(cachedEmails, filter);
        return Right(filteredEmails);
      }

      // If no cache, fetch from remote and filter
      if (await networkInfo.isConnected) {
        final remoteEmails = await remoteDataSource.getEmails();

        // Cache the emails
        try {
          await localDataSource.cacheEmails(remoteEmails);
        } catch (e) {
          print('Failed to cache emails: $e');
        }

        final filteredEmails = _filterEmailsByPriority(remoteEmails, filter);
        return Right(filteredEmails);
      } else {
        return Left(NetworkFailure());
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, EmailEntity>> getEmailById(String emailId) async {
    // First try to get from cache
    try {
      final cachedEmails = await localDataSource.getCachedEmails();

      if (cachedEmails != null && cachedEmails.isNotEmpty) {
        try {
          final email = cachedEmails.firstWhere((e) => e.id == emailId);
          return Right(email);
        } catch (e) {
          // Email not found in cache, try remote
        }
      }
    } on CacheException {
      // Cache error, try remote
    }

    // Try to fetch from remote
    if (await networkInfo.isConnected) {
      try {
        final email = await remoteDataSource.getEmailById(emailId);
        return Right(email);
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
  Future<Either<Failure, bool>> markAsRead(String emailId) async {
    // This is a local-only operation for now
    // You can implement API call if you have an endpoint for it
    try {
      final cachedEmails = await localDataSource.getCachedEmails();

      if (cachedEmails != null && cachedEmails.isNotEmpty) {
        // Find and update the email's read status
        final updatedEmails = cachedEmails.map((email) {
          if (email.id == emailId) {
            // Create a new email entity with isRead = true
            // You'll need to add a copyWith method to EmailEntity or EmailModel
            // For now, this is a placeholder
            return email; // You need to implement the update logic
          }
          return email;
        }).toList();

        // Cache the updated list
        await localDataSource.cacheEmails(updatedEmails);
        return const Right(true);
      }

      return const Right(false);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to mark email as read'));
    }
  }

  // Helper method to filter emails by priority
  List<EmailEntity> _filterEmailsByPriority(
    List<EmailEntity> emails,
    String filter,
  ) {
    if (filter.toLowerCase() == 'all') {
      return emails;
    }

    final EmailPriority priority;
    switch (filter.toLowerCase()) {
      case 'urgent':
        priority = EmailPriority.urgent;
        break;
      case 'normal':
        priority = EmailPriority.normal;
        break;
      case 'fyi':
        priority = EmailPriority.fyi;
        break;
      default:
        return emails;
    }

    return emails.where((email) => email.priority == priority).toList();
  }
}
