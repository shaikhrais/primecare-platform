import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/research_publication_drafting_model.dart';

class ResearchPublicationDraftingNotifier extends StateNotifier<ResearchPublicationDraftingModel> {
  ResearchPublicationDraftingNotifier() : super(const ResearchPublicationDraftingModel(isLoading: true));

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

final research_publication_draftingProvider = StateNotifierProvider<ResearchPublicationDraftingNotifier, ResearchPublicationDraftingModel>((ref) {
  return ResearchPublicationDraftingNotifier()..loadData();
});
