import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/features/head_of_marketing_dashboard/domain/models/head_of_marketing_dashboard_view_model.dart';
import 'package:flutter_core/features/head_of_marketing_dashboard/data/mappers/head_of_marketing_dashboard_mapper.dart';

final headOfMarketingDashboardAdapterProvider =
    FutureProvider<HeadOfMarketingDashboardViewModel>((ref) async {
      return HeadOfMarketingDashboardMapper.fromMock({});
    });
