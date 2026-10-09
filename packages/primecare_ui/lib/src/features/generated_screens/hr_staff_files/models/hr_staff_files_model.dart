import 'package:primecare_models/primecare_models.dart';

class HrStaffFilesModel extends BaseScreenState<HrStaffFilesModel> {
  const HrStaffFilesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrStaffFilesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrStaffFilesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
