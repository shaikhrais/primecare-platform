// Governance - Category: model | Purpose: Layer: 02_MODELS_FOUNDATION
// Layer: 02_MODELS_FOUNDATION
class DomainResponse {
  final Map<String, dynamic> data;
  final bool success;
  final String? message;
  final String? error;

  DomainResponse({
    required this.data,
    this.success = true,
    this.message,
    this.error,
  });

  factory DomainResponse.fromJson(Map<String, dynamic> json) {
    return DomainResponse(
      data: json['data'] as Map<String, dynamic>? ?? json,
      success: json['success'] as bool? ?? true,
      message: json['message'] as String?,
      error: json['error'] as String?,
    );
  }

  factory DomainResponse.error(String message) {
    return DomainResponse(data: {}, success: false, error: message);
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'success': success,
      'message': message,
      'error': error,
    };
  }
}
