import 'package:primecare_models/primecare_models.dart';

class TestingOverviewModel extends BaseScreenState<TestingOverviewModel> {
  const TestingOverviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TestingOverviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TestingOverviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
