import 'package:primecare_models/primecare_models.dart';

class ReceptionistVisitorsModel extends BaseScreenState<ReceptionistVisitorsModel> {
  const ReceptionistVisitorsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ReceptionistVisitorsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ReceptionistVisitorsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
