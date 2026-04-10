import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/client_dashboard_view_model.dart';
import '../mappers/client_dashboard_mapper.dart';

final clientDashboardAdapterProvider = FutureProvider<ClientDashboardViewModel>((ref) async {
  return ClientDashboardMapper.fromMock({});
});
