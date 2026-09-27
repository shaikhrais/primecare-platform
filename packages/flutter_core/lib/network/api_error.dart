// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE api_error.dart Converts complex low-level Backend/Dio exceptions into user-friendly UI strings.
// Layer: 01_INFRASTRUCTURE
// api_error.dart
import 'package:dio/dio.dart';

class ApiErrorAdapter {
  /// Converts complex low-level Backend/Dio exceptions into user-friendly UI strings.
  static String mapApiError(dynamic error) {
    if (error is DioException) {
      if (error.response?.statusCode == 401) {
        return 'Session expired. Please log in again.';
      }
      if (error.response?.statusCode == 403) {
        return 'Access denied. You do not have permission.';
      }
      if (error.response?.statusCode == 400) {
        return (error.response?.data as Map?)?['message']?.toString() ??
            'Invalid request submitted.';
      }
      if (error.response?.statusCode == 404) {
        return 'The requested resource could not be found.';
      }
      if (error.response?.statusCode == 500) {
        return 'Internal Server Error. Our team has been notified.';
      }
      if (error.type == DioExceptionType.connectionTimeout) {
        return 'Connection timed out. Please check your network.';
      }
    }
    return 'An unexpected error occurred. Please try again.';
  }
}
