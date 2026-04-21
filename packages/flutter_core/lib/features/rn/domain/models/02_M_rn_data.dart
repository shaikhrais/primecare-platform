// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rn_data.freezed.dart';
part 'rn_data.g.dart';

@freezed
abstract class RnData with _$RnData {
  const RnData._();
  const factory RnData({required Map<String, dynamic> metrics}) = _RnData;

  factory RnData.fromJson(Map<String, dynamic> json) => _$RnDataFromJson(json);

  factory RnData.fromDomain(Map<String, dynamic> data) => RnData(metrics: data);

  factory RnData.mock() => const RnData(metrics: {});
}
