import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/regional_manager_usa_dashboard_view_model.dart';
import '../mappers/regional_manager_usa_dashboard_mapper.dart';

final regionalManagerUsaDashboardAdapterProvider = FutureProvider<RegionalManagerUsaDashboardViewModel>((ref) async {
  return RegionalManagerUsaDashboardMapper.fromMock({});
});
