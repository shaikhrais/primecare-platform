import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/scheduler_dashboard_view_model.dart';
import '../mappers/scheduler_dashboard_mapper.dart';

final schedulerDashboardAdapterProvider = FutureProvider<SchedulerDashboardViewModel>((ref) async {
  return SchedulerDashboardMapper.fromMock({});
});
