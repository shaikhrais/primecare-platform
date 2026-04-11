import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/features/hr_hiring_dashboard/domain/models/hr_hiring_dashboard_view_model.dart';
import 'package:flutter_core/features/hr_hiring_dashboard/data/mappers/hr_hiring_dashboard_mapper.dart';

final hrHiringDashboardAdapterProvider =
    FutureProvider<HrHiringDashboardViewModel>((ref) async {
      return HrHiringDashboardMapper.fromMock({});
    });
