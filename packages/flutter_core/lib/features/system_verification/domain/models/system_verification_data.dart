import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_verification_data.freezed.dart';
part 'system_verification_data.g.dart';

@freezed
abstract class SystemVerificationData with _$SystemVerificationData {
  const SystemVerificationData._();
  const factory SystemVerificationData({
    required Map<String, dynamic> metrics,
  }) = _SystemVerificationData;

  factory SystemVerificationData.fromJson(Map<String, dynamic> json) =>
      _$SystemVerificationDataFromJson(json);

  factory SystemVerificationData.mock() =>
      const SystemVerificationData(metrics: {});
}
