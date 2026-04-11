import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/head_of_marketing_dashboard_view_model.dart';
import '../mappers/head_of_marketing_dashboard_mapper.dart';

final headOfMarketingDashboardAdapterProvider =
    FutureProvider<HeadOfMarketingDashboardViewModel>((ref) async {
      return HeadOfMarketingDashboardMapper.fromMock({});
    });
