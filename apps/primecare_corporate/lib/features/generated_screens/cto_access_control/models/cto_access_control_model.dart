import 'package:primecare_models/primecare_models.dart';

class CtoAccessControlModel extends BaseScreenState<CtoAccessControlModel> {
  const CtoAccessControlModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CtoAccessControlModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CtoAccessControlModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
