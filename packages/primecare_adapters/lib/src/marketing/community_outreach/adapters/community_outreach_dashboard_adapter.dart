import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/features/community_outreach_dashboard/domain/models/community_outreach_dashboard_view_model.dart';
import 'package:flutter_core/features/community_outreach_dashboard/data/mappers/community_outreach_dashboard_mapper.dart';

final communityOutreachDashboardAdapterProvider =
    FutureProvider<CommunityOutreachDashboardViewModel>((ref) async {
      return CommunityOutreachDashboardMapper.fromMock({});
    });
