import 'package:primecare_models/primecare_models.dart';

class VitalsEntryModel extends BaseScreenState<VitalsEntryModel> {
  const VitalsEntryModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  VitalsEntryModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => VitalsEntryModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
