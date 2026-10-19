import 'package:primecare_models/primecare_models.dart';

class VirtualConsultModel extends BaseScreenState<VirtualConsultModel> {
  const VirtualConsultModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  VirtualConsultModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => VirtualConsultModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
