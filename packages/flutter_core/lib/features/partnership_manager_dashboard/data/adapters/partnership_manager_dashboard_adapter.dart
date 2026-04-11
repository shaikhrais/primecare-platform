import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/partnership_manager_dashboard_view_model.dart';
import '../mappers/partnership_manager_dashboard_mapper.dart';

final partnershipManagerDashboardAdapterProvider =
    FutureProvider<PartnershipManagerDashboardViewModel>((ref) async {
      return PartnershipManagerDashboardMapper.fromMock({});
    });
