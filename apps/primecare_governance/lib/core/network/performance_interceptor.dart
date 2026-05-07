import 'package:dio/dio.dart';
import 'dart:developer' as dev;

class PerformanceInterceptor extends Interceptor {
  final Stopwatch _stopwatch = Stopwatch();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _stopwatch.start();
    dev.log('🚀 Request: [${options.method}] ${options.uri}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _stopwatch.stop();
    final duration = _stopwatch.elapsedMilliseconds;
    dev.log(
      '✅ Response: [${response.statusCode}] ${response.requestOptions.uri} ($duration ms)',
    );

    if (duration > 1000) {
      dev.log('⚠️ SLOW REQUEST detected: $duration ms');
    }

    _stopwatch.reset();
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _stopwatch.stop();
    dev.log('❌ Error: ${err.message} (${_stopwatch.elapsedMilliseconds} ms)');
    _stopwatch.reset();
    super.onError(err, handler);
  }
}
