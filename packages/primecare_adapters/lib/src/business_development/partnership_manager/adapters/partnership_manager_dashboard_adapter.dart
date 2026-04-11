import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/features/partnership_manager_dashboard/domain/models/partnership_manager_dashboard_view_model.dart';
import 'package:flutter_core/features/partnership_manager_dashboard/data/mappers/partnership_manager_dashboard_mapper.dart';

final partnershipManagerDashboardAdapterProvider =
    FutureProvider<PartnershipManagerDashboardViewModel>((ref) async {
      return PartnershipManagerDashboardMapper.fromMock({});
    });
