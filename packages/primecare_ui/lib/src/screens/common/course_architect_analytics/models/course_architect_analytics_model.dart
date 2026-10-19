import 'package:primecare_models/primecare_models.dart';

class CourseArchitectAnalyticsModel extends BaseScreenState<CourseArchitectAnalyticsModel> {
  const CourseArchitectAnalyticsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CourseArchitectAnalyticsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CourseArchitectAnalyticsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
