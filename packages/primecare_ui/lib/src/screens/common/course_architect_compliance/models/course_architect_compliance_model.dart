import 'package:primecare_models/primecare_models.dart';

class CourseArchitectComplianceModel extends BaseScreenState<CourseArchitectComplianceModel> {
  const CourseArchitectComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CourseArchitectComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CourseArchitectComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
