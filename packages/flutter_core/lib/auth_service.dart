// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE
// Layer: 01_INFRASTRUCTURE
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_core/flutter_core.dart' hide AuthState;



export 'package:primecare_models/src/models/auth_state.dart';
import 'package:primecare_models/src/models/auth_state.dart';
part 'src/application/controllers/auth_notifier.dart';

/// A transient presentation callback. Only the core verifier can issue authority.
typedef MfaPrompt = Future<void> Function(Map<String, dynamic> challenge, MfaVerifier verify);

/// The core owns both factor calls and limited recovery. Presentation cannot
/// supply a bearer token or turn a replacement challenge into session authority.
class MfaVerifier {
  final Future<bool> Function(String) _verify;
  final Future<Map<String, dynamic>?> Function(String) _recover;
  MfaVerifier({required Future<bool> Function(String) verify,
    required Future<Map<String, dynamic>?> Function(String) recover})
      : _verify = verify, _recover = recover;
  Future<bool> call(String code) => _verify(code);
  Future<Map<String, dynamic>?> recover(String code) => _recover(code);
}

enum MfaManagementAction { recoveryCodes, replace }

// Global listenable for GoRouter
final authListenable = ValueNotifier<bool>(false);



final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
