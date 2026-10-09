import 'package:primecare_models/primecare_models.dart';

class HrDirectorStaffFilesModel extends BaseScreenState<HrDirectorStaffFilesModel> {
  const HrDirectorStaffFilesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrDirectorStaffFilesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrDirectorStaffFilesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
