import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/features/franchise_sales_manager_dashboard/domain/models/franchise_sales_manager_dashboard_view_model.dart';
import 'package:flutter_core/features/franchise_sales_manager_dashboard/data/mappers/franchise_sales_manager_dashboard_mapper.dart';

final franchiseSalesManagerDashboardAdapterProvider =
    FutureProvider<FranchiseSalesManagerDashboardViewModel>((ref) async {
      return FranchiseSalesManagerDashboardMapper.fromMock({});
    });
