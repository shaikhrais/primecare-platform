// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';

part '02_M_physiotherapist_data.freezed.dart';
part '02_M_physiotherapist_data.g.dart';

@freezed
abstract class PhysiotherapistData with _$PhysiotherapistData {

  const factory PhysiotherapistData({required Map<String, dynamic> metrics}) =
      _PhysiotherapistData;

  factory PhysiotherapistData.fromJson(Map<String, dynamic> json) =>
      _$PhysiotherapistDataFromJson(json);

  factory PhysiotherapistData.mock() => const PhysiotherapistData(metrics: {});
}
