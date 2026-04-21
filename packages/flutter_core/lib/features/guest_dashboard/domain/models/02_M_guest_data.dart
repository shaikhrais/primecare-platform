// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';

part 'guest_data.freezed.dart';
part 'guest_data.g.dart';

@freezed
abstract class GuestData with _$GuestData {
  const GuestData._();
  const factory GuestData({required Map<String, dynamic> metrics}) = _GuestData;

  factory GuestData.fromJson(Map<String, dynamic> json) =>
      _$GuestDataFromJson(json);

  factory GuestData.mock() => const GuestData(metrics: {});
}
