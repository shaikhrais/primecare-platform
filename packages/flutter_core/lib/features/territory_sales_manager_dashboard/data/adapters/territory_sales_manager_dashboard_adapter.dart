import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/territory_sales_manager_dashboard_view_model.dart';
import '../mappers/territory_sales_manager_dashboard_mapper.dart';

final territorySalesManagerDashboardAdapterProvider = FutureProvider<TerritorySalesManagerDashboardViewModel>((ref) async {
  return TerritorySalesManagerDashboardMapper.fromMock({});
});
