import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/features/local_marketing_manager_dashboard/domain/models/local_marketing_manager_dashboard_view_model.dart';
import 'package:flutter_core/features/local_marketing_manager_dashboard/data/mappers/local_marketing_manager_dashboard_mapper.dart';

final localMarketingManagerDashboardAdapterProvider =
    FutureProvider<LocalMarketingManagerDashboardViewModel>((ref) async {
      return LocalMarketingManagerDashboardMapper.fromMock({});
    });
