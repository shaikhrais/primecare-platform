import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/features/general_manager_dashboard/domain/models/general_manager_dashboard_view_model.dart';
import 'package:flutter_core/features/general_manager_dashboard/data/mappers/general_manager_dashboard_mapper.dart';

final generalManagerDashboardAdapterProvider =
    FutureProvider<GeneralManagerDashboardViewModel>((ref) async {
      return GeneralManagerDashboardMapper.fromMock({});
    });
