// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_community_outreach_repository.dart';
import '../view_models/04_V_community_outreach_notifier.dart';

final communityOutreachRepositoryProvider =
    Provider<ICommunityOutreachRepository>((Ref ref) {
      return CommunityOutreachRepository(ref.watch(domainServiceProvider));
    });

final communityOutreachDashboardProvider =
    NotifierProvider<
      CommunityOutreachNotifier,
      AsyncValue<CommunityOutreachDashboardViewModel>
    >(() {
      return CommunityOutreachNotifier();
    });
