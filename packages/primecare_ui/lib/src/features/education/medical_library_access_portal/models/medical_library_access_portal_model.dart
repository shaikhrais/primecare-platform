import 'package:primecare_models/primecare_models.dart';

class MedicalLibraryAccessPortalModel extends BaseScreenState<MedicalLibraryAccessPortalModel> {
  const MedicalLibraryAccessPortalModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  MedicalLibraryAccessPortalModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => MedicalLibraryAccessPortalModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
