import 'base_response_envelope.dart';

// Governance - Category: model | Purpose: Layer: 01_MODELS
// Layer: 01_MODELS
class DomainResponse extends BaseResponseEnvelope {
  DomainResponse({
    required super.data,
    super.success = true,
    super.message,
    super.error,
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
}
