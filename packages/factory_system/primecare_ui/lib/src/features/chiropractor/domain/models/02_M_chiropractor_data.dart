// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';

part '02_M_chiropractor_data.freezed.dart';
part '02_M_chiropractor_data.g.dart';

@freezed
abstract class ChiropractorData with _$ChiropractorData {

  const factory ChiropractorData({required Map<String, dynamic> metrics}) =
      _ChiropractorData;

  factory ChiropractorData.fromJson(Map<String, dynamic> json) =>
      _$ChiropractorDataFromJson(json);

  factory ChiropractorData.mock() => const ChiropractorData(metrics: {});
}
