import 'package:primecare_models/primecare_models.dart';

class HrHiringStaffDocumentsModel extends BaseScreenState<HrHiringStaffDocumentsModel> {
  const HrHiringStaffDocumentsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrHiringStaffDocumentsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrHiringStaffDocumentsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
