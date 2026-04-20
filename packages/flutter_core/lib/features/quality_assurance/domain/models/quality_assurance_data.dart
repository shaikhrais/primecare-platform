import 'package:freezed_annotation/freezed_annotation.dart';

part 'quality_assurance_data.freezed.dart';
part 'quality_assurance_data.g.dart';

@freezed
abstract class QualityAssuranceData with _$QualityAssuranceData {
  const QualityAssuranceData._();
  const factory QualityAssuranceData({required Map<String, dynamic> metrics}) =
      _QualityAssuranceData;

  factory QualityAssuranceData.fromJson(Map<String, dynamic> json) =>
      _$QualityAssuranceDataFromJson(json);

  factory QualityAssuranceData.fromDomain(Map<String, dynamic> data) =>
      QualityAssuranceData.fromJson(data);

  factory QualityAssuranceData.mock() =>
      const QualityAssuranceData(metrics: {});
}
