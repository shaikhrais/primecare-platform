// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_marketing_data.freezed.dart';
part 'local_marketing_data.g.dart';

@freezed
abstract class LocalMarketingData with _$LocalMarketingData {
  const LocalMarketingData._();
  const factory LocalMarketingData({required Map<String, dynamic> metrics}) =
      _LocalMarketingData;

  factory LocalMarketingData.fromJson(Map<String, dynamic> json) =>
      _$LocalMarketingDataFromJson(json);

  factory LocalMarketingData.mock() => const LocalMarketingData(metrics: {});
}
