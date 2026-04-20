import '../../../../flutter_core.dart';
import '../../domain/repositories/quality_assurance_repository.dart';
import '../../domain/models/quality_assurance_state.dart';
import '../view_models/quality_assurance_notifier.dart';

final Provider<IQualityAssuranceRepository> qualityAssuranceRepositoryProvider =
    Provider<IQualityAssuranceRepository>((Ref ref) {
      return QualityAssuranceRepository(ref.watch(domainServiceProvider));
    });

final NotifierProvider<QualityAssuranceNotifier, QualityAssuranceState>
qualityAssuranceDashboardProvider =
    NotifierProvider<QualityAssuranceNotifier, QualityAssuranceState>(
      QualityAssuranceNotifier.new,
    );
