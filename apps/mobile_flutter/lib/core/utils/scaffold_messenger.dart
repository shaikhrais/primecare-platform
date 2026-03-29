import 'package:flutter/material.dart';

/// Global Key mapping enabling 100% decoupled Context-Free snackbars.
/// Resolves Architectural Audit #10: "Global Scaffold Messenger."
/// It allows services and controllers to throw UI alerts without needing `BuildContext`.
final GlobalKey<ScaffoldMessengerState> globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

class PrimeCareToasts {
  static void showSuccess(String message) {
    globalMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void showError(String message) {
    globalMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
