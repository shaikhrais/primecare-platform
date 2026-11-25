import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_api_errors/primecare_api_errors.dart';

void main() {
  test('preserves denied and expired session messages', () {
    final request = RequestOptions(path: '/fixture');
    DioException failure(int code) => DioException(requestOptions: request, response: Response(requestOptions: request, statusCode: code));
    expect(ApiErrorAdapter.mapApiError(failure(401)), 'Session expired. Please log in again.');
    expect(ApiErrorAdapter.mapApiError(failure(403)), 'Access denied. You do not have permission.');
    expect(ApiErrorAdapter.mapApiError(null), 'An unexpected error occurred. Please try again.');
  });
}
