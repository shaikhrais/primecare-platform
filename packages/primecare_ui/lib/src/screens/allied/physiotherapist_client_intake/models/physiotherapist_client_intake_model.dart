import 'package:primecare_models/primecare_models.dart';

class PhysiotherapistClientIntakeModel extends BaseScreenState<PhysiotherapistClientIntakeModel> {
  const PhysiotherapistClientIntakeModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PhysiotherapistClientIntakeModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PhysiotherapistClientIntakeModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
