/// Shared message rules; transport adapters identify their own exception types.
class ApiErrorPolicy {
  static String mapResponse({
    int? statusCode,
    dynamic data,
    bool connectionTimeout = false,
  }) {
    if (statusCode == 401) {
      return 'Session expired. Please log in again.';
    }
    if (statusCode == 403) {
      return 'Access denied. You do not have permission.';
    }
    if (statusCode == 400) {
      return (data as Map?)?['message']?.toString() ??
          'Invalid request submitted.';
    }
    if (statusCode == 404) {
      return 'The requested resource could not be found.';
    }
    if (statusCode == 500) {
      return 'Internal Server Error. Our team has been notified.';
    }
    if (connectionTimeout) {
      return 'Connection timed out. Please check your network.';
    }
    return 'An unexpected error occurred. Please try again.';
  }
}
