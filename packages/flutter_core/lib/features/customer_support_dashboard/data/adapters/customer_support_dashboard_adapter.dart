import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/customer_support_dashboard_view_model.dart';
import '../mappers/customer_support_dashboard_mapper.dart';

final customerSupportDashboardAdapterProvider =
    FutureProvider<CustomerSupportDashboardViewModel>((ref) async {
      return CustomerSupportDashboardMapper.fromMock({});
    });
