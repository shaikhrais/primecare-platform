import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/billing_admin_dashboard_view_model.dart';
import '../mappers/billing_admin_dashboard_mapper.dart';

final billingAdminDashboardAdapterProvider = FutureProvider<BillingAdminDashboardViewModel>((ref) async {
  return BillingAdminDashboardMapper.fromMock({});
});
