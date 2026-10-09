import 'package:primecare_models/primecare_models.dart';

class QualityAssuranceDashboardModel extends BaseScreenState<QualityAssuranceDashboardModel> {
  const QualityAssuranceDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  QualityAssuranceDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => QualityAssuranceDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
