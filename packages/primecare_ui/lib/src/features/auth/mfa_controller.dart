import 'dart:async';
import 'package:primecare_ui/primecare_ui.dart';

/// Challenge/code are transient; neither is persisted or logged.
class MfaState {
  final String code;
  final bool isLoading;
  final bool failed;
  final Map<String, dynamic>? challenge;
  const MfaState({this.code = '', this.isLoading = false, this.failed = false, this.challenge});
  bool get pending => challenge != null;
}

class MfaController extends Notifier<MfaState> {
  Completer<void>? _prompt;
  Future<bool> Function(String)? _verify;
  int _revision = 0;
  @override
  MfaState build() {
    ref.onDispose(() { _revision++; _verify = null; final prompt = _prompt; if (prompt != null && !prompt.isCompleted) prompt.complete(); });
    return const MfaState();
  }
  Future<void> request(Map<String, dynamic> challenge, Future<bool> Function(String) verify) {
    cancel();
    final prompt = Completer<void>(); _prompt = prompt; _verify = verify;
    state = MfaState(challenge: Map<String, dynamic>.unmodifiable(challenge));
    return prompt.future;
  }
  void onCodeChanged(String value) {
    if (!state.pending || state.isLoading) return;
    state = MfaState(code: value, challenge: state.challenge);
  }
  Future<void> verify() async {
    final verifier = _verify;
    if (state.isLoading || !state.pending || verifier == null) return;
    if (!RegExp(r'^[0-9]{6}$').hasMatch(state.code)) {
      state = MfaState(challenge: state.challenge, failed: true); return;
    }
    final revision = _revision, challenge = state.challenge, code = state.code;
    state = MfaState(challenge: challenge, isLoading: true);
    var accepted = false;
    try { accepted = await verifier(code); } catch (_) {}
    if (!ref.mounted || revision != _revision) return;
    if (accepted) { cancel(); } else { state = MfaState(challenge: challenge, failed: true); }
  }
  void cancel() {
    _revision++; _verify = null;
    final prompt = _prompt; _prompt = null;
    if (ref.mounted) state = const MfaState();
    if (prompt != null && !prompt.isCompleted) prompt.complete();
  }
}
final mfaControllerProvider = NotifierProvider<MfaController, MfaState>(() => MfaController());
