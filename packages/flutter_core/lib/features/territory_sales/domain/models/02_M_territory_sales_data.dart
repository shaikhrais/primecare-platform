// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';

part 'territory_sales_data.freezed.dart';
part 'territory_sales_data.g.dart';

@freezed
abstract class TerritorySalesData with _$TerritorySalesData {
  const TerritorySalesData._();
  const factory TerritorySalesData({required Map<String, dynamic> metrics}) =
      _TerritorySalesData;

  factory TerritorySalesData.fromJson(Map<String, dynamic> json) =>
      _$TerritorySalesDataFromJson(json);

  factory TerritorySalesData.mock() => const TerritorySalesData(metrics: {});
}
