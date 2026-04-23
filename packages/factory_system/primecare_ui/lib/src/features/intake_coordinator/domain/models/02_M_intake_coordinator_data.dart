// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';

part '02_M_intake_coordinator_data.freezed.dart';
part '02_M_intake_coordinator_data.g.dart';

@freezed
abstract class IntakeCoordinatorData with _$IntakeCoordinatorData {

  const factory IntakeCoordinatorData({required Map<String, dynamic> metrics}) =
      _IntakeCoordinatorData;

  factory IntakeCoordinatorData.fromJson(Map<String, dynamic> json) =>
      _$IntakeCoordinatorDataFromJson(json);

  factory IntakeCoordinatorData.mock() =>
      const IntakeCoordinatorData(metrics: {});
}
