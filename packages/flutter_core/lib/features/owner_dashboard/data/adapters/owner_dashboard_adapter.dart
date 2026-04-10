import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/owner_dashboard_view_model.dart';
import '../mappers/owner_dashboard_mapper.dart';

final ownerDashboardAdapterProvider = FutureProvider<OwnerDashboardViewModel>((ref) async {
  return OwnerDashboardMapper.fromMock({});
});
