import 'exceptions.dart';
import '../responses/failure.dart';

class ErrorMapper {
  static Failure map(Exception e) {
    if (e is ServerException) {
      return Failure('Server error: ${e.message}');
    } else if (e is CacheException) {
      return Failure('Cache error: ${e.message}');
    } else {
      return Failure('Unexpected error: ${e.toString()}');
    }
  }
}
