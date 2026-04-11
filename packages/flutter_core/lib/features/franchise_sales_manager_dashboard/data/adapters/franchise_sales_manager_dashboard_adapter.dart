import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/franchise_sales_manager_dashboard_view_model.dart';
import '../mappers/franchise_sales_manager_dashboard_mapper.dart';

final franchiseSalesManagerDashboardAdapterProvider =
    FutureProvider<FranchiseSalesManagerDashboardViewModel>((ref) async {
      return FranchiseSalesManagerDashboardMapper.fromMock({});
    });
