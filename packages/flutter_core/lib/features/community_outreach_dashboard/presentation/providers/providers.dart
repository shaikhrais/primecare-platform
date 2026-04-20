import '../../../../flutter_core.dart';
import '../../domain/repositories/community_outreach_repository.dart';
import '../view_models/community_outreach_notifier.dart';

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
