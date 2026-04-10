import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/ceo_dashboard_view_model.dart';
import '../mappers/ceo_dashboard_mapper.dart';

final ceoDashboardAdapterProvider = FutureProvider<CeoDashboardViewModel>((ref) async {
  return CeoDashboardMapper.fromMock({});
});
