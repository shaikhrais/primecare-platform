// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hr_manager_data.freezed.dart';
part 'hr_manager_data.g.dart';

@freezed
abstract class HrManagerData with _$HrManagerData {
  const HrManagerData._();
  const factory HrManagerData({required Map<String, dynamic> metrics}) =
      _HrManagerData;

  factory HrManagerData.fromJson(Map<String, dynamic> json) =>
      _$HrManagerDataFromJson(json);

  factory HrManagerData.mock() => const HrManagerData(metrics: {});
}
