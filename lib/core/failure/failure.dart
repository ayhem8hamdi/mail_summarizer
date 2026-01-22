// lib/core/errors/failures.dart
import 'package:equatable/equatable.dart';
import 'package:inbox_iq/core/failure/exceptions.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? details;

  const Failure({required this.message, this.details});

  @override
  List<Object?> get props => [message, details];

  // Factory constructor to create appropriate failure from exceptions
  factory Failure.fromException(dynamic exception) {
    if (exception is ServerException) {
      return ServerFailure.fromException(exception);
    } else if (exception is CacheException) {
      return CacheFailure.fromException(exception);
    } else if (exception is NetworkException) {
      return NetworkFailure.fromException(exception);
    } else {
      return UnexpectedFailure(
        message: 'An unexpected error occurred',
        details: exception.toString(),
      );
    }
  }

  // User-friendly error message
  String get userMessage {
    switch (runtimeType) {
      case const (ServerFailure):
        return 'Server error. Please try again later.';
      case const (NetworkFailure):
        return 'No internet connection. Please check your network.';
      case const (CacheFailure):
        return 'Failed to load cached data.';
      case const (TimeoutFailure):
        return 'Request timeout. Please try again.';
      case const (UnauthorizedFailure):
        return 'Unauthorized access. Please login again.';
      case const (NotFoundFailure):
        return 'Resource not found.';
      default:
        return message;
    }
  }
}

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure({required super.message, this.statusCode, super.details});

  factory ServerFailure.fromException(ServerException exception) {
    return ServerFailure(
      message: exception.message,
      statusCode: exception.statusCode,
      details: exception.details,
    );
  }

  @override
  List<Object?> get props => [message, statusCode, details];
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection',
    super.details,
  });

  factory NetworkFailure.fromException(NetworkException exception) {
    return NetworkFailure(
      message: exception.message,
      details: exception.details,
    );
  }
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.details});

  factory CacheFailure.fromException(CacheException exception) {
    return CacheFailure(message: exception.message, details: exception.details);
  }
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({super.message = 'Request timeout', super.details});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'Unauthorized access',
    super.details,
  });
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message = 'Resource not found', super.details});
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({required super.message, super.details});
}

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
