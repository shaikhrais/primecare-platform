import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/features/customer_support_dashboard/domain/models/customer_support_dashboard_view_model.dart';
import 'package:flutter_core/features/customer_support_dashboard/data/mappers/customer_support_dashboard_mapper.dart';

final customerSupportDashboardAdapterProvider =
    FutureProvider<CustomerSupportDashboardViewModel>((ref) async {
      return CustomerSupportDashboardMapper.fromMock({});
    });
