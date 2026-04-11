import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/features/territory_expansion_manager_dashboard/domain/models/territory_expansion_manager_dashboard_view_model.dart';
import 'package:flutter_core/features/territory_expansion_manager_dashboard/data/mappers/territory_expansion_manager_dashboard_mapper.dart';

final territoryExpansionManagerDashboardAdapterProvider =
    FutureProvider<TerritoryExpansionManagerDashboardViewModel>((ref) async {
      return TerritoryExpansionManagerDashboardMapper.fromMock({});
    });
