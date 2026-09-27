import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/registry_entry_editor_model.dart';

class RegistryEntryEditorNotifier extends StateNotifier<RegistryEntryEditorModel> {
  RegistryEntryEditorNotifier() : super(const RegistryEntryEditorModel(isLoading: true));

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

final registry_entry_editorProvider = StateNotifierProvider<RegistryEntryEditorNotifier, RegistryEntryEditorModel>((ref) {
  return RegistryEntryEditorNotifier()..loadData();
});
