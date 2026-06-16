import 'dart:async';
import 'dart:developer' as developer;

import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  RetryInterceptor(
    this._dio, {
    this.maxRetries = 2,
    this.fallbackBackoff = const Duration(seconds: 2),
    this.maxAcceptableWait = const Duration(seconds: 5),
  });

  static const String _retryCountKey = '__retry_count';

  final Dio _dio;
  final int maxRetries;
  final Duration fallbackBackoff;
  final Duration maxAcceptableWait;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_shouldRetry(err)) {
      handler.next(err);
      return;
    }

    final int attempt =
        (err.requestOptions.extra[_retryCountKey] as int?) ?? 0;
    if (attempt >= maxRetries) {
      handler.next(err);
      return;
    }

    final Duration? wait = _waitDuration(err, attempt);
    if (wait == null) {
      developer.log(
        'Got HTTP ${err.response?.statusCode} on ${err.requestOptions.path}; '
        'server-suggested wait exceeds ${maxAcceptableWait.inSeconds}s — '
        'failing fast',
        name: 'dio.retry',
      );
      handler.next(err);
      return;
    }

    developer.log(
      'Got HTTP ${err.response?.statusCode} on ${err.requestOptions.path}; '
      'retry ${attempt + 1}/$maxRetries after $wait',
      name: 'dio.retry',
    );
    await Future<void>.delayed(wait);

    final RequestOptions retryOptions = err.requestOptions.copyWith(
      extra: <String, dynamic>{
        ...err.requestOptions.extra,
        _retryCountKey: attempt + 1,
      },
    );

    try {
      final Response<dynamic> response = await _dio.fetch<dynamic>(
        retryOptions,
      );
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  bool _shouldRetry(DioException err) {
    final int? code = err.response?.statusCode;
    if (code == 429) {
      return true;
    }
    if (code != null && code >= 500 && code < 600) {
      return true;
    }
    return false;
  }

  Duration? _waitDuration(DioException err, int attempt) {
    final Headers? headers = err.response?.headers;
    if (headers != null) {
      final String? raw = headers.value('retry-after');
      if (raw != null) {
        final int? seconds = int.tryParse(raw);
        if (seconds != null && seconds > 0) {
          final Duration suggested = Duration(seconds: seconds);
          if (suggested > maxAcceptableWait) {
            return null;
          }
          return suggested;
        }
      }
    }
    final int seconds =
        (fallbackBackoff.inSeconds << attempt).clamp(1, maxAcceptableWait.inSeconds);
    return Duration(seconds: seconds);
  }
}
