/// Exception thrown when there is a server error
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});

  @override
  String toString() => 'ServerException: $message (Status Code: $statusCode)';
}

/// Exception thrown when there is a cache error
class CacheException implements Exception {
  final String message;

  CacheException({required this.message});

  @override
  String toString() => 'CacheException: $message';
}

/// Exception thrown when there is a network error
class NetworkException implements Exception {
  final String message;

  NetworkException({required this.message});

  @override
  String toString() => 'NetworkException: $message';
}

/// Exception thrown when there is a validation error
class ValidationException implements Exception {
  final String message;
  final Map<String, List<String>>? errors;

  ValidationException({required this.message, this.errors});

  @override
  String toString() => 'ValidationException: $message';
}

/// Exception thrown when there is an authentication error
class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({required this.message});

  @override
  String toString() => 'AuthenticationException: $message';
}
