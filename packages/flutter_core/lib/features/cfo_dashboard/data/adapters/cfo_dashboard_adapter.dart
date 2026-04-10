import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/cfo_dashboard_view_model.dart';
import '../mappers/cfo_dashboard_mapper.dart';

final cfoDashboardAdapterProvider = FutureProvider<CfoDashboardViewModel>((ref) async {
  return CfoDashboardMapper.fromMock({});
});
