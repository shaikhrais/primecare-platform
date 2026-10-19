import 'package:primecare_models/primecare_models.dart';

class ServiceIssueModel extends BaseScreenState<ServiceIssueModel> {
  const ServiceIssueModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ServiceIssueModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ServiceIssueModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
