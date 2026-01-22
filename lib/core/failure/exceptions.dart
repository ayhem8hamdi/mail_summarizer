class ServerException implements Exception {
  final String message;
  final int? statusCode;
  final String? details;

  ServerException({required this.message, this.statusCode, this.details});

  factory ServerException.fromDioError(dynamic error) {
    if (error.response != null) {
      final statusCode = error.response?.statusCode;

      switch (statusCode) {
        case 400:
          return ServerException(
            message: 'Bad request',
            statusCode: statusCode,
            details: error.response?.data?.toString(),
          );
        case 401:
          return ServerException(
            message: 'Unauthorized',
            statusCode: statusCode,
            details: 'Invalid credentials or session expired',
          );
        case 403:
          return ServerException(
            message: 'Forbidden',
            statusCode: statusCode,
            details: 'You don\'t have permission to access this resource',
          );
        case 404:
          return ServerException(
            message: 'Not found',
            statusCode: statusCode,
            details: 'The requested resource was not found',
          );
        case 500:
          return ServerException(
            message: 'Internal server error',
            statusCode: statusCode,
            details: 'Something went wrong on the server',
          );
        case 503:
          return ServerException(
            message: 'Service unavailable',
            statusCode: statusCode,
            details: 'The service is temporarily unavailable',
          );
        default:
          return ServerException(
            message: 'Server error',
            statusCode: statusCode,
            details: error.response?.data?.toString(),
          );
      }
    } else {
      return ServerException(message: 'Network error', details: error.message);
    }
  }

  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

class CacheException implements Exception {
  final String message;
  final String? details;

  CacheException({required this.message, this.details});

  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String message;
  final String? details;

  NetworkException({this.message = 'No internet connection', this.details});

  @override
  String toString() => 'NetworkException: $message';
}

class TimeoutException implements Exception {
  final String message;
  final String? details;

  TimeoutException({this.message = 'Request timeout', this.details});

  @override
  String toString() => 'TimeoutException: $message';
}
