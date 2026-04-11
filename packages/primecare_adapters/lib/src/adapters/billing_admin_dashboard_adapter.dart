import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/features/billing_admin_dashboard/domain/models/billing_admin_dashboard_view_model.dart';
import 'package:flutter_core/features/billing_admin_dashboard/data/mappers/billing_admin_dashboard_mapper.dart';

final billingAdminDashboardAdapterProvider =
    FutureProvider<BillingAdminDashboardViewModel>((ref) async {
      return BillingAdminDashboardMapper.fromMock({});
    });
