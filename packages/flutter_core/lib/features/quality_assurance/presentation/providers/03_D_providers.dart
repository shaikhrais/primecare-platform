// Layer: 03_DATA_DOMAIN_LOGIC
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_quality_assurance_repository.dart';
import '../../domain/models/02_M_quality_assurance_state.dart';
import '../view_models/04_V_quality_assurance_notifier.dart';

final Provider<IQualityAssuranceRepository> qualityAssuranceRepositoryProvider =
    Provider<IQualityAssuranceRepository>((Ref ref) {
      return QualityAssuranceRepository(ref.watch(domainServiceProvider));
    });

final NotifierProvider<QualityAssuranceNotifier, QualityAssuranceState>
qualityAssuranceDashboardProvider =
    NotifierProvider<QualityAssuranceNotifier, QualityAssuranceState>(
      QualityAssuranceNotifier.new,
    );
