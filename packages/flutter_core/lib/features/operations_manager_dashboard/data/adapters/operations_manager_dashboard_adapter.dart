import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/operations_manager_dashboard_view_model.dart';
import '../mappers/operations_manager_dashboard_mapper.dart';

final operationsManagerDashboardAdapterProvider =
    FutureProvider<OperationsManagerDashboardViewModel>((ref) async {
      return OperationsManagerDashboardMapper.fromMock({});
    });
