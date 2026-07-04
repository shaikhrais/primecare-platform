import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chemotherapy_protocol_builder_model.dart';

class ChemotherapyProtocolBuilderNotifier extends StateNotifier<ChemotherapyProtocolBuilderModel> {
  ChemotherapyProtocolBuilderNotifier() : super(const ChemotherapyProtocolBuilderModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const {});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final chemotherapy_protocol_builderProvider = StateNotifierProvider<ChemotherapyProtocolBuilderNotifier, ChemotherapyProtocolBuilderModel>((ref) {
  return ChemotherapyProtocolBuilderNotifier()..loadData();
});
