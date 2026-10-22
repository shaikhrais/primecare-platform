import 'dart:async';
import 'package:primecare_ui/primecare_ui.dart';
import 'mfa_catalog.g.dart';

class MfaManagementState {
  final bool canManage, working, failed, finished;
  final String password, factor, newCode;
  final Map<String, dynamic>? replacement;
  final List<String> recoveryCodes;
  const MfaManagementState({this.canManage = false, this.working = false, this.failed = false,
    this.finished = false, this.password = '', this.factor = '', this.newCode = '',
    this.replacement, this.recoveryCodes = const []});
  MfaManagementState inputs({String? password, String? factor, String? newCode}) =>
    MfaManagementState(canManage: canManage, password: password ?? this.password,
      factor: factor ?? this.factor, newCode: newCode ?? this.newCode, replacement: replacement,
      recoveryCodes: recoveryCodes);
}

/// Self-only presentation orchestration. Core owns proof, endpoints and authority.
class MfaManagementController extends Notifier<MfaManagementState> {
  int _revision = 0;
  Timer? _expiry;
  @override
  MfaManagementState build() {
    ref.onDispose(() {_revision++; _expiry?.cancel();});
    // No listener may retain one-time codes or accept a late proof response.
    final lifetime = ref;
    ref.onCancel(() {
      _revision++;
      _expiry?.cancel();
      // Riverpod forbids provider mutations inside lifecycle callbacks. Stop
      // late work synchronously, then discard cached proof outside the callback.
      scheduleMicrotask(() {
        if (lifetime.mounted) lifetime.invalidateSelf();
      });
    });
    ref.listen(authProvider, (previous, next) {
      if (previous?.userId != next.userId || previous?.role != next.role || !next.isAuthenticated) cancel();
    });
    return MfaManagementState(canManage: ref.read(authProvider.notifier).canManageMfa);
  }
  void onPasswordChanged(String value) {if (!state.working) state = state.inputs(password: value);}
  void onFactorChanged(String value) {if (!state.working) state = state.inputs(factor: value);}
  void onNewCodeChanged(String value) {if (!state.working) state = state.inputs(newCode: value);}
  Future<void> issueCodes() => _submit(MfaManagementAction.recoveryCodes);
  Future<void> replace() => _submit(MfaManagementAction.replace);
  Future<void> _submit(MfaManagementAction action) async {
    if (!state.canManage || state.working || state.replacement != null || state.recoveryCodes.isNotEmpty) return;
    final password = state.password, factor = state.factor, revision = ++_revision;
    if (password.isEmpty || !RegExp(r'^[0-9]{6}$').hasMatch(factor)) {
      state = MfaManagementState(canManage: true, failed: true); return;
    }
    state = const MfaManagementState(canManage: true, working: true);
    Map<String, dynamic>? result;
    try {result = await ref.read(authProvider.notifier).manageMfa(action, password, factor);} catch (_) {}
    if (!ref.mounted || revision != _revision) return;
    state = result == null ? const MfaManagementState(canManage: true, failed: true)
      : action == MfaManagementAction.recoveryCodes
        ? MfaManagementState(canManage: true, recoveryCodes: List<String>.unmodifiable((result['recoveryCodes'] as List).cast<String>()))
        : MfaManagementState(canManage: true, replacement: result);
    if (state.replacement != null) {
      _expiry?.cancel();
      _expiry = Timer(const Duration(seconds: nativeMfaChallengeLifetimeSeconds), () {if (ref.mounted) cancel();});
    }
  }
  Future<void> confirm() async {
    final replacement = state.replacement;
    if (!state.canManage || state.working || replacement == null) return;
    final code = state.newCode, revision = ++_revision;
    if (!RegExp(r'^[0-9]{6}$').hasMatch(code)) {
      state = MfaManagementState(canManage: true, replacement: replacement, failed: true); return;
    }
    state = MfaManagementState(canManage: true, replacement: replacement, working: true);
    var accepted = false;
    try {accepted = await ref.read(authProvider.notifier).confirmManagedMfa(replacement['challenge'] as String, code);} catch (_) {}
    if (!ref.mounted || revision != _revision) return;
    if (accepted) _expiry?.cancel();
    state = accepted ? const MfaManagementState(canManage: true, finished: true)
      : MfaManagementState(canManage: true, replacement: replacement, failed: true);
  }
  void saved() {if (!state.working) state = MfaManagementState(canManage: state.canManage, finished: true);}
  void cancel() {
    _revision++; _expiry?.cancel();
    if (ref.mounted) state = MfaManagementState(canManage: ref.read(authProvider.notifier).canManageMfa);
  }
}

// Codes and setup keys disappear when the management page loses its listener.
final mfaManagementProvider = NotifierProvider.autoDispose<MfaManagementController, MfaManagementState>(MfaManagementController.new);
