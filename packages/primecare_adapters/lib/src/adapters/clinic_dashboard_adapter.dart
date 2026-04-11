import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/features/clinic_dashboard/domain/models/clinic_dashboard_view_model.dart';
import 'package:flutter_core/features/clinic_dashboard/data/mappers/clinic_dashboard_mapper.dart';

final clinicDashboardAdapterProvider = FutureProvider<ClinicDashboardViewModel>(
  (ref) async {
    return ClinicDashboardMapper.fromMock({});
  },
);
