import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/clinic_dashboard_view_model.dart';
import '../mappers/clinic_dashboard_mapper.dart';

final clinicDashboardAdapterProvider = FutureProvider<ClinicDashboardViewModel>((ref) async {
  return ClinicDashboardMapper.fromMock({});
});
