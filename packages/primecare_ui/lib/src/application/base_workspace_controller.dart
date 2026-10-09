import 'package:flutter_riverpod/legacy.dart';
import 'package:primecare_models/primecare_models.dart';

/// Existing workspace presentation transitions shared by screen controllers.
abstract class BaseWorkspaceController<T extends BaseWorkspaceState<T>>
    extends StateNotifier<T> {
  BaseWorkspaceController(super.state);

  void addLog(String entry) {
    state = state.copyWith(logs: [...state.logs, entry]);
  }

  void toggleLoading() {
    state = state.copyWith(isLoading: true, error: null);
  }

  void toggleError(String msg) {
    state = state.copyWith(isLoading: false, error: msg, hasData: false);
  }

  void toggleEmpty() {
    state = state.copyWith(isLoading: false, error: null, hasData: false);
  }

  void toggleSuccess() {
    state = state.copyWith(isLoading: false, error: null, hasData: true);
  }
}
