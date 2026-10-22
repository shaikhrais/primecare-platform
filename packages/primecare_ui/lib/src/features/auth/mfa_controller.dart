import 'dart:async';
import 'package:primecare_ui/primecare_ui.dart';
import 'mfa_catalog.g.dart';

/// Challenge/code are transient; neither is persisted or logged.
class MfaState {
  final String code;
  final bool isLoading;
  final bool failed;
  final Map<String, dynamic>? challenge;
  final String recoveryCode;
  final bool recoveryMode, recoveryAvailable;
  const MfaState({this.code = '', this.isLoading = false, this.failed = false, this.challenge,
    this.recoveryCode = '', this.recoveryMode = false, this.recoveryAvailable = false});
  bool get pending => challenge != null;
}

class MfaController extends Notifier<MfaState> {
  Completer<void>? _prompt;
  Future<bool> Function(String)? _verify;
  Future<Map<String, dynamic>?> Function(String)? _recover;
  int _revision = 0;
  Timer? _expiry;
  @override
  MfaState build() {
    ref.onDispose(() { _revision++; _expiry?.cancel(); _verify = null; _recover = null; final prompt = _prompt; if (prompt != null && !prompt.isCompleted) prompt.complete(); });
    return const MfaState();
  }
  Future<void> request(Map<String, dynamic> challenge, Future<bool> Function(String) verify,
      {Future<Map<String, dynamic>?> Function(String)? recover}) {
    cancel();
    final prompt = Completer<void>(); _prompt = prompt; _verify = verify; _recover = recover;
    state = MfaState(challenge: Map<String, dynamic>.unmodifiable(challenge),
      recoveryAvailable: recover != null && challenge['purpose'] == 'verify');
    _startExpiry();
    return prompt.future;
  }
  void _startExpiry() {
    _expiry?.cancel();
    _expiry = Timer(const Duration(seconds: nativeMfaChallengeLifetimeSeconds), () {if (ref.mounted) cancel();});
  }
  void onCodeChanged(String value) {
    if (!state.pending || state.isLoading || state.recoveryMode) return;
    state = MfaState(code: value, challenge: state.challenge, recoveryAvailable: state.recoveryAvailable);
  }
  void showRecovery() {
    if (!state.recoveryAvailable || state.isLoading) return;
    state = MfaState(challenge: state.challenge, recoveryAvailable: true, recoveryMode: true);
  }
  void showAuthenticator() {
    if (state.isLoading) return;
    state = MfaState(challenge: state.challenge, recoveryAvailable: state.recoveryAvailable);
  }
  void onRecoveryCodeChanged(String value) {
    if (!state.recoveryMode || state.isLoading) return;
    state = MfaState(challenge: state.challenge, recoveryAvailable: state.recoveryAvailable,
      recoveryMode: true, recoveryCode: value.trim().toUpperCase());
  }
  Future<void> recover() async {
    final recover = _recover;
    if (!state.recoveryMode || !state.recoveryAvailable || state.isLoading || recover == null) return;
    final revision = _revision, challenge = state.challenge, savedCode = state.recoveryCode;
    state = MfaState(challenge: challenge, recoveryAvailable: true, recoveryMode: true, isLoading: true);
    Map<String, dynamic>? next;
    if (RegExp(r'^[A-Z2-7]{26}$').hasMatch(savedCode)) {
      try {next = await recover(savedCode);} catch (_) {}
    }
    if (!ref.mounted || revision != _revision) return;
    state = next == null
      ? MfaState(challenge: challenge, recoveryAvailable: true, recoveryMode: true, failed: true)
      : MfaState(challenge: next);
    if (next != null) _startExpiry();
  }
  Future<void> verify() async {
    final verifier = _verify;
    if (state.isLoading || !state.pending || state.recoveryMode || verifier == null) return;
    if (!RegExp(r'^[0-9]{6}$').hasMatch(state.code)) {
      state = MfaState(challenge: state.challenge, recoveryAvailable: state.recoveryAvailable, failed: true); return;
    }
    final revision = _revision, challenge = state.challenge, code = state.code, recoveryAvailable = state.recoveryAvailable;
    state = MfaState(challenge: challenge, recoveryAvailable: recoveryAvailable, isLoading: true);
    var accepted = false;
    try { accepted = await verifier(code); } catch (_) {}
    if (!ref.mounted || revision != _revision) return;
    if (accepted) { cancel(); } else { state = MfaState(challenge: challenge, recoveryAvailable: recoveryAvailable, failed: true); }
  }
  void cancel() {
    _revision++; _expiry?.cancel(); _verify = null; _recover = null;
    final prompt = _prompt; _prompt = null;
    if (ref.mounted) state = const MfaState();
    if (prompt != null && !prompt.isCompleted) prompt.complete();
  }
}
final mfaControllerProvider = NotifierProvider<MfaController, MfaState>(() => MfaController());
