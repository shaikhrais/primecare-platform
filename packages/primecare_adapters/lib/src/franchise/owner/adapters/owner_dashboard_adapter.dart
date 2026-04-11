import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/features/owner_dashboard/domain/models/owner_dashboard_view_model.dart';
import 'package:flutter_core/features/owner_dashboard/data/mappers/owner_dashboard_mapper.dart';

final ownerDashboardAdapterProvider = FutureProvider<OwnerDashboardViewModel>((
  ref,
) async {
  return OwnerDashboardMapper.fromMock({});
});
