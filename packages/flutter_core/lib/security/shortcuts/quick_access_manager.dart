// Governance - Category: service | Purpose: Processes a keyboard event and checks if it matches a registered shortcut.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'shortcut_model.dart';
import 'shortcut_registry.dart';
import 'shortcut_permission_engine.dart';
import '../../models/governance_role.dart';
import '../../aura_behavioral_telemetry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuickAccessManager {
  static final QuickAccessManager instance = QuickAccessManager._internal();
  
  QuickAccessManager._internal();

  int _failedAttempts = 0;
  DateTime? _lastAttemptTime;
  double _sessionRiskScore = 0.0;
  static const int _maxFailedAttemptsBeforeLockout = 5;
  static const Duration _abuseResetDuration = Duration(minutes: 5);

  /// Processes a keyboard event and checks if it matches a registered shortcut.
  bool handleKeyEvent({
    required Set<LogicalKeyboardKey> pressedKeys,
    required GovernanceRole currentUserRole,
    required String currentOffice,
    required void Function(String featureId) onAccessGranted,
    void Function(ShortcutRule rule)? onAccessDenied,
    void Function()? onLockout,
    AuraBehavioralTelemetry? telemetry,
  }) {
    final rule = PrimeCareShortcutRegistry.findByKeys(pressedKeys);
    if (rule == null) {
      return false; // Not a registered shortcut
    }

    _checkAbuseReset();

    if (_failedAttempts >= _maxFailedAttemptsBeforeLockout) {
      print('[SECURITY ALERT] Shortcut system locked due to abuse detection.');
      if (onLockout != null) onLockout();
      return true; // Handled (blocked)
    }

    final isAllowed = ShortcutPermissionEngine.evaluate(
      rule: rule,
      userRole: currentUserRole,
      currentOffice: currentOffice,
    );

    if (isAllowed) {
      _logAccess(rule, true, currentUserRole.role.name, telemetry);
      onAccessGranted(rule.featureId);
      return true;
    } else {
      _failedAttempts++;
      _lastAttemptTime = DateTime.now();
      _sessionRiskScore += 15.0; // Increase risk score
      _logAccess(rule, false, currentUserRole.role.name, telemetry);
      
      if (_failedAttempts >= _maxFailedAttemptsBeforeLockout) {
        print('[SECURITY CRITICAL] Repeated unauthorized shortcut attempts. Risk Score: $_sessionRiskScore');
        if (onLockout != null) onLockout();
      } else if (onAccessDenied != null) {
        onAccessDenied(rule);
      }
      return true; // We handled it, but denied access
    }
  }

  void _checkAbuseReset() {
    if (_lastAttemptTime != null) {
      final diff = DateTime.now().difference(_lastAttemptTime!);
      if (diff > _abuseResetDuration) {
        _failedAttempts = 0;
        _sessionRiskScore = 0.0;
      }
    }
  }

  void _logAccess(ShortcutRule rule, bool granted, String roleName, AuraBehavioralTelemetry? telemetry) {
    final status = granted ? 'GRANTED' : 'DENIED';
    // Integrate with AuraBehavioralTelemetry
    if (telemetry != null) {
      telemetry.logQuickAccessAttempt(
        shortcutId: rule.id,
        featureId: rule.featureId,
        granted: granted,
        roleName: roleName,
        riskScore: _sessionRiskScore,
      );
    }
    print('[SECURITY AUDIT] Quick Access $status for shortcut ${rule.id} (Feature: ${rule.featureId}) by role $roleName. Current Risk Score: $_sessionRiskScore');
  }
}

class QuickAccessBoundary extends ConsumerStatefulWidget {
  final Widget child;
  final GovernanceRole userRole;
  final String currentOffice;

  const QuickAccessBoundary({
    super.key,
    required this.child,
    required this.userRole,
    required this.currentOffice,
  });

  @override
  ConsumerState<QuickAccessBoundary> createState() => _QuickAccessBoundaryState();
}

class _QuickAccessBoundaryState extends ConsumerState<QuickAccessBoundary> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      final pressedKeys = HardwareKeyboard.instance.logicalKeysPressed;
      final telemetry = ref.read(auraBehavioralTelemetryProvider);
      final handled = QuickAccessManager.instance.handleKeyEvent(
        pressedKeys: pressedKeys,
        currentUserRole: widget.userRole,
        currentOffice: widget.currentOffice,
        telemetry: telemetry,
        onAccessGranted: (featureId) {
          // Find route for featureId or trigger global action
          _routeToFeature(featureId);
        },
        onAccessDenied: (rule) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Unauthorized access. Incident logged.'),
              backgroundColor: Colors.red,
            ),
          );
        },
        onLockout: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('SYSTEM LOCKED: Multiple unauthorized access attempts detected. Risk incident reported.'),
              backgroundColor: Colors.red[900],
              duration: Duration(seconds: 10),
            ),
          );
          // In a real scenario, this might trigger a forceful logout or redirect to a security challenge screen.
        },
      );
      if (handled) return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  void _routeToFeature(String featureId) {
    // Basic routing based on featureId, could be expanded to look up route in registry
    String? route;
    switch (featureId) {
      case 'ADMIN_DASHBOARD':
        route = '/admin/dashboard';
        break;
      case 'HR_DASHBOARD':
        route = '/corporate/hr';
        break;
      case 'BILLING_DASHBOARD':
        route = '/corporate/finance';
        break;
      case 'CLINICAL_DASHBOARD':
        route = '/clinical/dashboard';
        break;
      case 'CLINIC_MANAGER_DASHBOARD':
        route = '/clinical/management';
        break;
      case 'EMERGENCY_DASHBOARD':
        route = '/admin/emergency';
        break;
      case 'ENGINEERING_DASHBOARD':
        route = '/admin/engineering';
        break;
      case 'GOVERNANCE_DASHBOARD':
        route = '/admin/governance';
        break;
      // Handle other global actions
    }

    if (route != null) {
      context.go(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      autofocus: true,
      child: widget.child,
    );
  }
}
