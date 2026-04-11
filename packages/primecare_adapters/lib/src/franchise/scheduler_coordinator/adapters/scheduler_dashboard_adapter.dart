import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/features/scheduler_dashboard/domain/models/scheduler_dashboard_view_model.dart';
import 'package:flutter_core/features/scheduler_dashboard/data/mappers/scheduler_dashboard_mapper.dart';

final schedulerDashboardAdapterProvider =
    FutureProvider<SchedulerDashboardViewModel>((ref) async {
      return SchedulerDashboardMapper.fromMock({});
    });
