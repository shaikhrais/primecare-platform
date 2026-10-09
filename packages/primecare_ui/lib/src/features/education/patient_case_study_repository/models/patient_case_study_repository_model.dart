import 'package:primecare_models/primecare_models.dart';

class PatientCaseStudyRepositoryModel extends BaseScreenState<PatientCaseStudyRepositoryModel> {
  const PatientCaseStudyRepositoryModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PatientCaseStudyRepositoryModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PatientCaseStudyRepositoryModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
