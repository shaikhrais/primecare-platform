import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/features/operations_manager_dashboard/domain/models/operations_manager_dashboard_view_model.dart';
import 'package:flutter_core/features/operations_manager_dashboard/data/mappers/operations_manager_dashboard_mapper.dart';

final operationsManagerDashboardAdapterProvider =
    FutureProvider<OperationsManagerDashboardViewModel>((ref) async {
      return OperationsManagerDashboardMapper.fromMock({});
    });
