import 'package:primecare_models/primecare_models.dart';

class RmtClientIntakeModel extends BaseScreenState<RmtClientIntakeModel> {
  const RmtClientIntakeModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RmtClientIntakeModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RmtClientIntakeModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
