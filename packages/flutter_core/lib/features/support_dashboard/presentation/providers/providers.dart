import '../../../../flutter_core.dart';
import '../../domain/repositories/support_repository.dart';
import '../view_models/support_notifier.dart';

final supportRepositoryProvider = Provider<ISupportRepository>((ref) {
  return SupportRepository(ref.watch(dashboardServiceProvider));
});

final supportNotifierProvider =
    NotifierProvider<SupportNotifier, AsyncValue<SupportDashboardViewModel>>(
      SupportNotifier.new,
    );
