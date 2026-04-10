import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/local_marketing_manager_dashboard_view_model.dart';
import '../mappers/local_marketing_manager_dashboard_mapper.dart';

final localMarketingManagerDashboardAdapterProvider = FutureProvider<LocalMarketingManagerDashboardViewModel>((ref) async {
  return LocalMarketingManagerDashboardMapper.fromMock({});
});
