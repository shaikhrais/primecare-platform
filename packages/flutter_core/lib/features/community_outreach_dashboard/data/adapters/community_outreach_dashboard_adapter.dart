import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/community_outreach_dashboard_view_model.dart';
import '../mappers/community_outreach_dashboard_mapper.dart';

final communityOutreachDashboardAdapterProvider = FutureProvider<CommunityOutreachDashboardViewModel>((ref) async {
  return CommunityOutreachDashboardMapper.fromMock({});
});
