import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/general_manager_dashboard_view_model.dart';
import '../mappers/general_manager_dashboard_mapper.dart';

final generalManagerDashboardAdapterProvider =
    FutureProvider<GeneralManagerDashboardViewModel>((ref) async {
      return GeneralManagerDashboardMapper.fromMock({});
    });
