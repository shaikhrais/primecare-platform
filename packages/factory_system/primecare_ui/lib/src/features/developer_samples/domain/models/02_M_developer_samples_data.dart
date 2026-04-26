// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';

part '02_M_developer_samples_data.freezed.dart';
part '02_M_developer_samples_data.g.dart';

@freezed
abstract class DeveloperSamplesData with _$DeveloperSamplesData {
  const factory DeveloperSamplesData({required Map<String, dynamic> metrics}) =
      _DeveloperSamplesData;

  factory DeveloperSamplesData.fromJson(Map<String, dynamic> json) =>
      _$DeveloperSamplesDataFromJson(json);

  factory DeveloperSamplesData.mock() =>
      const DeveloperSamplesData(metrics: {});
}
