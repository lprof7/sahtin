// utils/result.dart
import '../models/failure.dart';

// Result<T> يمثل النجاح أو الفشل
class Result<T> {
  final T? data;
  final Failure? error;
  final bool isSuccess;

  Result._({this.data, this.error, required this.isSuccess});

  factory Result.success(T data) => Result._(data: data, isSuccess: true);

  factory Result.failure(Failure error) =>
      Result._(error: error, isSuccess: false);
}
