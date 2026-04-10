import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/family_dashboard_view_model.dart';
import '../mappers/family_dashboard_mapper.dart';

final familyDashboardAdapterProvider = FutureProvider<FamilyDashboardViewModel>((ref) async {
  return FamilyDashboardMapper.fromMock({});
});
