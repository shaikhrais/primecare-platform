import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/features/client_dashboard/domain/models/client_dashboard_view_model.dart';
import 'package:flutter_core/features/client_dashboard/data/mappers/client_dashboard_mapper.dart';

final clientDashboardAdapterProvider = FutureProvider<ClientDashboardViewModel>(
  (ref) async {
    return ClientDashboardMapper.fromMock({});
  },
);
