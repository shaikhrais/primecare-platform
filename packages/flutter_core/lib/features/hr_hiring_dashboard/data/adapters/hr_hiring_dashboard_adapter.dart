import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/hr_hiring_dashboard_view_model.dart';
import '../mappers/hr_hiring_dashboard_mapper.dart';

final hrHiringDashboardAdapterProvider = FutureProvider<HrHiringDashboardViewModel>((ref) async {
  return HrHiringDashboardMapper.fromMock({});
});
