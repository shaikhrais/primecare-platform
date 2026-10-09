/// Existing domain response envelope, shared without changing parsing policy.
abstract class BaseResponseEnvelope {
  final Map<String, dynamic> data;
  final bool success;
  final String? message;
  final String? error;
  BaseResponseEnvelope({
    required this.data,
    this.success = true,
    this.message,
    this.error,
  });
  Map<String, dynamic> toJson() => {
    'data': data,
    'success': success,
    'message': message,
    'error': error,
  };
}
