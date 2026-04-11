import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/features/head_of_bus_dev_dashboard/domain/models/head_of_bus_dev_dashboard_view_model.dart';
import 'package:flutter_core/features/head_of_bus_dev_dashboard/data/mappers/head_of_bus_dev_dashboard_mapper.dart';

final headOfBusDevDashboardAdapterProvider =
    FutureProvider<HeadOfBusDevDashboardViewModel>((ref) async {
      return HeadOfBusDevDashboardMapper.fromMock({});
    });
