import 'package:primecare_models/primecare_models.dart';

class HswIncidentReportsModel extends BaseScreenState<HswIncidentReportsModel> {
  const HswIncidentReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HswIncidentReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HswIncidentReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
