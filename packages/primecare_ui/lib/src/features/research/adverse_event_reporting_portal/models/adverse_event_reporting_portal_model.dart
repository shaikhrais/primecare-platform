import 'package:primecare_models/primecare_models.dart';

class AdverseEventReportingPortalModel extends BaseScreenState<AdverseEventReportingPortalModel> {
  const AdverseEventReportingPortalModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AdverseEventReportingPortalModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AdverseEventReportingPortalModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
