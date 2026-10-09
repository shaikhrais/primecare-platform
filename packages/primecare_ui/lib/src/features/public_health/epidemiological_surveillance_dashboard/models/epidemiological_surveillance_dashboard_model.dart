import 'package:primecare_models/primecare_models.dart';

class EpidemiologicalSurveillanceDashboardModel extends BaseScreenState<EpidemiologicalSurveillanceDashboardModel> {
  const EpidemiologicalSurveillanceDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  EpidemiologicalSurveillanceDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => EpidemiologicalSurveillanceDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
