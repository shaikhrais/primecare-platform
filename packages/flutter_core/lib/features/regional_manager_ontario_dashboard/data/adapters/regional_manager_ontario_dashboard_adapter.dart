import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/regional_manager_ontario_dashboard_view_model.dart';
import '../mappers/regional_manager_ontario_dashboard_mapper.dart';

final regionalManagerOntarioDashboardAdapterProvider = FutureProvider<RegionalManagerOntarioDashboardViewModel>((ref) async {
  return RegionalManagerOntarioDashboardMapper.fromMock({});
});
