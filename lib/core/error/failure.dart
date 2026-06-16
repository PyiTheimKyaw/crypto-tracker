sealed class Failure {
  const Failure(this.message);

  final String message;

  @override
  String toString() => '$runtimeType($message)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message);

  @override
  int get hashCode => Object.hash(runtimeType, message);
}

final class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error']);
}

final class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error']);
}

final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}
