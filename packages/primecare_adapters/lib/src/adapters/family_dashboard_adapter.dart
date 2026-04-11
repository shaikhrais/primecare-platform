import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/features/family_dashboard/domain/models/family_dashboard_view_model.dart';
import 'package:flutter_core/features/family_dashboard/data/mappers/family_dashboard_mapper.dart';

final familyDashboardAdapterProvider = FutureProvider<FamilyDashboardViewModel>(
  (ref) async {
    return FamilyDashboardMapper.fromMock({});
  },
);
