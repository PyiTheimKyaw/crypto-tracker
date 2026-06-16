import 'dart:typed_data';

import 'package:crypto_tracker/core/network/retry_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

class _CountingAdapter implements HttpClientAdapter {
  _CountingAdapter(this._responses);

  final List<ResponseBody Function()> _responses;
  int calls = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final ResponseBody Function() next =
        _responses[calls.clamp(0, _responses.length - 1)];
    calls += 1;
    return next();
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _ok() => ResponseBody.fromString(
  '"ok"',
  200,
  headers: <String, List<String>>{
    'content-type': <String>['application/json'],
  },
);

ResponseBody _rateLimited({String? retryAfter}) {
  return ResponseBody.fromString(
    '{"status":{"error_code":429,"error_message":"rate limit"}}',
    429,
    headers: <String, List<String>>{
      'content-type': <String>['application/json'],
      if (retryAfter != null) 'retry-after': <String>[retryAfter],
    },
  );
}

Dio _dioWith({required _CountingAdapter adapter, Duration? backoff}) {
  final Dio dio = Dio();
  dio.httpClientAdapter = adapter;
  dio.interceptors.add(
    RetryInterceptor(
      dio,
      fallbackBackoff: backoff ?? const Duration(milliseconds: 1),
    ),
  );
  return dio;
}

void main() {
  test('retries once on 429 then succeeds', () async {
    final _CountingAdapter adapter = _CountingAdapter(<ResponseBody Function()>[
      () => _rateLimited(),
      _ok,
    ]);
    final Dio dio = _dioWith(adapter: adapter);

    final Response<dynamic> response = await dio.get<dynamic>(
      'https://example.com/x',
    );

    expect(response.statusCode, 200);
    expect(adapter.calls, 2);
  });

  test('gives up after maxRetries (default 2)', () async {
    final _CountingAdapter adapter = _CountingAdapter(<ResponseBody Function()>[
      () => _rateLimited(),
    ]);
    final Dio dio = _dioWith(adapter: adapter);

    await expectLater(
      dio.get<dynamic>('https://example.com/x'),
      throwsA(
        isA<DioException>().having(
          (DioException e) => e.response?.statusCode,
          'statusCode',
          429,
        ),
      ),
    );
    expect(adapter.calls, 3);
  });

  test('fails fast when Retry-After exceeds maxAcceptableWait', () async {
    final _CountingAdapter adapter = _CountingAdapter(<ResponseBody Function()>[
      () => _rateLimited(retryAfter: '30'),
    ]);
    final Dio dio = _dioWith(adapter: adapter);

    final Stopwatch sw = Stopwatch()..start();
    await expectLater(
      dio.get<dynamic>('https://example.com/x'),
      throwsA(
        isA<DioException>().having(
          (DioException e) => e.response?.statusCode,
          'statusCode',
          429,
        ),
      ),
    );
    sw.stop();

    expect(adapter.calls, 1);
    expect(sw.elapsed.inSeconds, lessThan(2));
  });

  test('honors Retry-After header for the wait duration', () async {
    final _CountingAdapter adapter = _CountingAdapter(<ResponseBody Function()>[
      () => _rateLimited(retryAfter: '1'),
      _ok,
    ]);
    final Dio dio = _dioWith(
      adapter: adapter,
      backoff: const Duration(milliseconds: 1),
    );

    final Stopwatch sw = Stopwatch()..start();
    await dio.get<dynamic>('https://example.com/x');
    sw.stop();

    expect(adapter.calls, 2);
    expect(sw.elapsed.inMilliseconds, greaterThanOrEqualTo(1000));
  });

  test('retries on 5xx as well', () async {
    final _CountingAdapter adapter = _CountingAdapter(<ResponseBody Function()>[
      () => ResponseBody.fromString('error', 503),
      _ok,
    ]);
    final Dio dio = _dioWith(adapter: adapter);

    final Response<dynamic> response = await dio.get<dynamic>(
      'https://example.com/x',
    );

    expect(response.statusCode, 200);
    expect(adapter.calls, 2);
  });

  test('does not retry on 400 client errors', () async {
    final _CountingAdapter adapter = _CountingAdapter(<ResponseBody Function()>[
      () => ResponseBody.fromString('bad', 400),
    ]);
    final Dio dio = _dioWith(adapter: adapter);

    await expectLater(
      dio.get<dynamic>('https://example.com/x'),
      throwsA(isA<DioException>()),
    );
    expect(adapter.calls, 1);
  });
}
