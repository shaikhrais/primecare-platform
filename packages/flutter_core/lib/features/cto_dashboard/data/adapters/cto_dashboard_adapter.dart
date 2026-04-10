import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/cto_dashboard_view_model.dart';
import '../mappers/cto_dashboard_mapper.dart';

final ctoDashboardAdapterProvider = FutureProvider<CtoDashboardViewModel>((ref) async {
  return CtoDashboardMapper.fromMock({});
});
