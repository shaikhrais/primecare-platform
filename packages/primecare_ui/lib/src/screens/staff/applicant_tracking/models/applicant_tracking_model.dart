import 'package:primecare_models/primecare_models.dart';

class ApplicantTrackingModel extends BaseScreenState<ApplicantTrackingModel> {
  const ApplicantTrackingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ApplicantTrackingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ApplicantTrackingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
