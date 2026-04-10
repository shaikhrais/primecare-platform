import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/coo_dashboard_view_model.dart';
import '../mappers/coo_dashboard_mapper.dart';

final cooDashboardAdapterProvider = FutureProvider<CooDashboardViewModel>((ref) async {
  return CooDashboardMapper.fromMock({});
});
