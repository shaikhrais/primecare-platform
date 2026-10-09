import 'package:primecare_models/primecare_models.dart';

class DrugInteractionAlertCenterModel extends BaseScreenState<DrugInteractionAlertCenterModel> {
  const DrugInteractionAlertCenterModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  DrugInteractionAlertCenterModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => DrugInteractionAlertCenterModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
