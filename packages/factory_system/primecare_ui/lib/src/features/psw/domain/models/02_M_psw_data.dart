// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';

part '02_M_psw_data.freezed.dart';
part '02_M_psw_data.g.dart';

@freezed
abstract class PswData with _$PswData {

  const factory PswData({required Map<String, dynamic> metrics}) = _PswData;

  factory PswData.fromJson(Map<String, dynamic> json) =>
      _$PswDataFromJson(json);

  factory PswData.fromDomain(Map<String, dynamic> data) =>
      PswData(metrics: data);

  factory PswData.mock() => const PswData(metrics: {});
}
