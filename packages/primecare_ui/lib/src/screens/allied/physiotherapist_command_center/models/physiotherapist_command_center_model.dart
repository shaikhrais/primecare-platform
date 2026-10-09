import 'package:primecare_models/primecare_models.dart';

class PhysiotherapistCommandCenterModel extends BaseScreenState<PhysiotherapistCommandCenterModel> {
  const PhysiotherapistCommandCenterModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PhysiotherapistCommandCenterModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PhysiotherapistCommandCenterModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
