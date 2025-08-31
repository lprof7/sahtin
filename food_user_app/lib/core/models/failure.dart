import 'package:easy_localization/easy_localization.dart';

abstract class Failure {
  final String message;
  Failure(this.message);
}

class NetworkFailure extends Failure {
  NetworkFailure([String message = "network_failure"]) : super(message.tr());
}

class ServerFailure extends Failure {
  final int? statusCode;
  ServerFailure(this.statusCode, [String message = "server_failure"])
    : super(message.tr());
}

class CacheFailure extends Failure {
  CacheFailure([String message = "cache_failure"]) : super(message.tr());
}

class UnknownFailure extends Failure {
  UnknownFailure([String message = "unknown_failure"]) : super(message.tr());
}
