// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rpn_data.freezed.dart';
part 'rpn_data.g.dart';

@freezed
abstract class RpnData with _$RpnData {
  const RpnData._();
  const factory RpnData({required Map<String, dynamic> metrics}) = _RpnData;

  factory RpnData.fromJson(Map<String, dynamic> json) =>
      _$RpnDataFromJson(json);

  factory RpnData.fromDomain(Map<String, dynamic> data) =>
      RpnData(metrics: data);

  factory RpnData.mock() => const RpnData(metrics: {});
}
