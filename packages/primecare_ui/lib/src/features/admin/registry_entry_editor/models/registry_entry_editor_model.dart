import 'package:primecare_models/primecare_models.dart';

class RegistryEntryEditorModel extends BaseScreenState<RegistryEntryEditorModel> {
  const RegistryEntryEditorModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegistryEntryEditorModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegistryEntryEditorModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
