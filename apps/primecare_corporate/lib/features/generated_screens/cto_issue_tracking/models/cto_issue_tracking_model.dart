import 'package:primecare_models/primecare_models.dart';

class CtoIssueTrackingModel extends BaseScreenState<CtoIssueTrackingModel> {
  const CtoIssueTrackingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CtoIssueTrackingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CtoIssueTrackingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
