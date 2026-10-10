/// A standardized response object for the [ApiClient].
class ApiResponse {
  final dynamic data;
  final int statusCode;
  final String? error;

  ApiResponse({required this.data, required this.statusCode, this.error});

  bool get isSuccess => statusCode >= 200 && statusCode < 300;
}
