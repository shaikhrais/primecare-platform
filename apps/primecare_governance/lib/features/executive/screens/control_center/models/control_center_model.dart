import 'package:primecare_models/primecare_models.dart';

class ControlCenterModel extends BaseScreenState<ControlCenterModel> {
  const ControlCenterModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ControlCenterModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ControlCenterModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
