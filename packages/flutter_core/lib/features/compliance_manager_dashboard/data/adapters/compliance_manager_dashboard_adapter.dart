import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/compliance_manager_dashboard_view_model.dart';
import '../mappers/compliance_manager_dashboard_mapper.dart';

final complianceManagerDashboardAdapterProvider = FutureProvider<ComplianceManagerDashboardViewModel>((ref) async {
  return ComplianceManagerDashboardMapper.fromMock({});
});
