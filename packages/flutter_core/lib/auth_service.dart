// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE
// Layer: 01_INFRASTRUCTURE
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_core/flutter_core.dart' hide AuthState;



export 'package:primecare_models/src/models/auth_state.dart';
import 'package:primecare_models/src/models/auth_state.dart';
part 'src/application/controllers/auth_notifier.dart';

/// A transient presentation callback. Only the core verifier can issue authority.
typedef MfaPrompt = Future<void> Function(Map<String, dynamic> challenge, Future<bool> Function(String code) verify);

// Global listenable for GoRouter
final authListenable = ValueNotifier<bool>(false);



final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
