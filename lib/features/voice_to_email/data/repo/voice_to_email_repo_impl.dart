import 'package:dartz/dartz.dart';
import 'package:inbox_iq/core/connection_checker.dart/network_info.dart';
import 'package:inbox_iq/core/failure/failure.dart';
import 'package:inbox_iq/features/voice_to_email/data/remote/voice_to_email_remote_data_source.dart';
import 'package:inbox_iq/features/voice_to_email/domain/entities/voice_to_email_response_entity.dart';
import 'package:inbox_iq/features/voice_to_email/domain/repo/voice_to_email_repo.dart';

class VoiceEmailRepositoryImpl implements VoiceEmailRepository {
  final VoiceEmailRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  VoiceEmailRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, VoiceEmailResponseEntity>> generateEmailFromVoice({
    required dynamic audioFile,
    required String userId,
    required DateTime timestamp,
  }) async {
    // Check network connectivity
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final response = await remoteDataSource.generateEmailFromVoice(
        audioFile: audioFile,
        userId: userId,
        timestamp: timestamp,
      );
      return Right(response);
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, bool>> sendEmail({
    required String to,
    required String subject,
    required String body,
    required String userId,
  }) async {
    // Check network connectivity
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final success = await remoteDataSource.sendEmail(
        to: to,
        subject: subject,
        body: body,
        userId: userId,
      );
      return Right(success);
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
