import 'package:freezed_annotation/freezed_annotation.dart';
import 'territory_sales_data.dart';

part 'territory_sales_state.freezed.dart';

@freezed
abstract class TerritorySalesState with _$TerritorySalesState {
  const factory TerritorySalesState.initial() = _Initial;
  const factory TerritorySalesState.loading() = _Loading;
  const factory TerritorySalesState.loaded({required TerritorySalesData data}) =
      _Loaded;
  const factory TerritorySalesState.error(String message) = _Error;
}
