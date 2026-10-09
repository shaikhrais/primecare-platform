import 'package:primecare_models/primecare_models.dart';

class PswHelpSupportModel extends BaseScreenState<PswHelpSupportModel> {
  const PswHelpSupportModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswHelpSupportModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswHelpSupportModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
