// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';

part '02_M_system_verification_data.freezed.dart';
part '02_M_system_verification_data.g.dart';

@freezed
abstract class SystemVerificationData with _$SystemVerificationData {
  const factory SystemVerificationData({
    required Map<String, dynamic> metrics,
  }) = _SystemVerificationData;

  factory SystemVerificationData.fromJson(Map<String, dynamic> json) =>
      _$SystemVerificationDataFromJson(json);

  factory SystemVerificationData.mock() =>
      const SystemVerificationData(metrics: {});
}
