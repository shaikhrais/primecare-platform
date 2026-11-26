// Governance - Category: service | Purpose: Core implementation file for the Shortcut Registry platform logic.
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'shortcut_model.dart';

class PrimeCareShortcutRegistry {
  static final List<ShortcutRule> globalShortcuts = [
    ShortcutRule(
      id: 'UNIVERSAL_SEARCH',
      featureId: 'GLOBAL_SEARCH',
      category: ShortcutCategory.GLOBAL,
      allowedRoles: ['ALL'],
      allowedOffices: ['ALL'],
      securityLevel: SecurityLevel.LOW,
      requiresGovernanceApproval: false,
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyK),
      description: 'Universal search (filtered results only)',
    ),
    ShortcutRule(
      id: 'CREATE_RECORD',
      featureId: 'GLOBAL_CREATE',
      category: ShortcutCategory.GLOBAL,
      allowedRoles: ['ALL'],
      allowedOffices: ['ALL'],
      securityLevel: SecurityLevel.LOW,
      requiresGovernanceApproval: true,
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift, LogicalKeyboardKey.keyN),
      description: 'Create allowed record',
    ),
    ShortcutRule(
      id: 'USER_MESSAGES',
      featureId: 'GLOBAL_MESSAGES',
      category: ShortcutCategory.GLOBAL,
      allowedRoles: ['ALL'],
      allowedOffices: ['ALL'],
      securityLevel: SecurityLevel.LOW,
      requiresGovernanceApproval: false,
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift, LogicalKeyboardKey.keyM),
      description: 'User messages',
    ),
    ShortcutRule(
      id: 'CLIENT_SEARCH',
      featureId: 'GLOBAL_CLIENT_SEARCH',
      category: ShortcutCategory.GLOBAL,
      allowedRoles: ['ALL'],
      allowedOffices: ['ALL'],
      securityLevel: SecurityLevel.LOW,
      requiresGovernanceApproval: true,
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift, LogicalKeyboardKey.keyP),
      description: 'Allowed client search',
    ),
    ShortcutRule(
      id: 'USER_SCHEDULER',
      featureId: 'GLOBAL_SCHEDULER',
      category: ShortcutCategory.GLOBAL,
      allowedRoles: ['ALL'],
      allowedOffices: ['ALL'],
      securityLevel: SecurityLevel.LOW,
      requiresGovernanceApproval: true,
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift, LogicalKeyboardKey.keyS),
      description: 'User scheduler',
    ),
    ShortcutRule(
      id: 'HELP',
      featureId: 'GLOBAL_HELP',
      category: ShortcutCategory.GLOBAL,
      allowedRoles: ['ALL'],
      allowedOffices: ['ALL'],
      securityLevel: SecurityLevel.LOW,
      requiresGovernanceApproval: false,
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.slash),
      description: 'Help',
    ),
    ShortcutRule(
      id: 'HOME',
      featureId: 'GLOBAL_HOME',
      category: ShortcutCategory.GLOBAL,
      allowedRoles: ['ALL'],
      allowedOffices: ['ALL'],
      securityLevel: SecurityLevel.LOW,
      requiresGovernanceApproval: false,
      keySet: LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.digit1),
      description: 'Home',
    ),
  ];

  static final List<ShortcutRule> roleSpecificShortcuts = [
    // ADMIN ONLY
    ShortcutRule(
      id: 'SUPER_ADMIN_DASHBOARD',
      featureId: 'ADMIN_DASHBOARD',
      category: ShortcutCategory.ADMIN,
      allowedRoles: ['SUPER_ADMIN'],
      allowedOffices: ['CORPORATE'],
      securityLevel: SecurityLevel.CRITICAL,
      requiresGovernanceApproval: true,
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift, LogicalKeyboardKey.keyA),
      description: 'Super Admin Dashboard',
    ),
    ShortcutRule(
      id: 'GOVERNANCE_TEAM',
      featureId: 'GOVERNANCE_DASHBOARD',
      category: ShortcutCategory.GOVERNANCE,
      allowedRoles: ['GOVERNANCE_ADMIN', 'SUPER_ADMIN'],
      allowedOffices: ['CORPORATE'],
      securityLevel: SecurityLevel.CRITICAL,
      requiresGovernanceApproval: true,
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift, LogicalKeyboardKey.keyG),
      description: 'Governance Team',
    ),
    ShortcutRule(
      id: 'SYSTEM_ENGINEERS',
      featureId: 'ENGINEERING_DASHBOARD',
      category: ShortcutCategory.DEVELOPER,
      allowedRoles: ['CTO', 'SYSTEM_ENGINEER', 'SUPER_ADMIN'],
      allowedOffices: ['CORPORATE'],
      securityLevel: SecurityLevel.CRITICAL,
      requiresGovernanceApproval: true,
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift, LogicalKeyboardKey.keyX),
      description: 'System Engineers',
    ),
    ShortcutRule(
      id: 'EMERGENCY_TEAM',
      featureId: 'EMERGENCY_DASHBOARD',
      category: ShortcutCategory.EMERGENCY,
      allowedRoles: ['EMERGENCY_LEAD', 'SUPER_ADMIN'],
      allowedOffices: ['CORPORATE', 'FRANCHISE'],
      securityLevel: SecurityLevel.CRITICAL,
      requiresGovernanceApproval: true,
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift, LogicalKeyboardKey.keyE),
      description: 'Emergency Team',
    ),
    
    // HR ONLY
    ShortcutRule(
      id: 'HR_DASHBOARD',
      featureId: 'HR_DASHBOARD',
      category: ShortcutCategory.ROLE_SPECIFIC,
      allowedRoles: ['HR_MANAGER', 'HR_ASSISTANT', 'SUPER_ADMIN'],
      allowedOffices: ['CORPORATE', 'FRANCHISE'],
      securityLevel: SecurityLevel.HIGH,
      requiresGovernanceApproval: true,
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift, LogicalKeyboardKey.keyH),
      description: 'HR Department Dashboard',
    ),

    // FINANCE / BILLING ONLY
    ShortcutRule(
      id: 'BILLING_DASHBOARD',
      featureId: 'BILLING_DASHBOARD',
      category: ShortcutCategory.FINANCE,
      allowedRoles: ['FINANCE_DIRECTOR', 'BILLING_ADMIN', 'SUPER_ADMIN'],
      allowedOffices: ['CORPORATE', 'FRANCHISE'],
      securityLevel: SecurityLevel.HIGH,
      requiresGovernanceApproval: true,
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift, LogicalKeyboardKey.keyB),
      description: 'Finance/Billing Dashboard',
    ),

    // CLINICAL ONLY
    ShortcutRule(
      id: 'CLINICAL_LEAD_DASHBOARD',
      featureId: 'CLINICAL_DASHBOARD',
      category: ShortcutCategory.CLINICAL,
      allowedRoles: ['CLINICAL_LEAD', 'SUPER_ADMIN'],
      allowedOffices: ['CLINICAL', 'CORPORATE'],
      securityLevel: SecurityLevel.HIGH,
      requiresGovernanceApproval: true,
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift, LogicalKeyboardKey.keyT),
      description: 'Clinical Leads Dashboard',
    ),
    ShortcutRule(
      id: 'CLINIC_MANAGER_DASHBOARD',
      featureId: 'CLINIC_MANAGER_DASHBOARD',
      category: ShortcutCategory.CLINICAL,
      allowedRoles: ['CLINIC_MANAGER', 'SUPER_ADMIN'],
      allowedOffices: ['CLINICAL'],
      securityLevel: SecurityLevel.HIGH,
      requiresGovernanceApproval: true,
      keySet: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift, LogicalKeyboardKey.keyC),
      description: 'Clinic Managers Dashboard',
    ),
  ];

  static List<ShortcutRule> get allShortcuts => [
    ...globalShortcuts,
    ...roleSpecificShortcuts,
  ];

  static ShortcutRule? findByKeys(Set<LogicalKeyboardKey> pressedKeys) {
    for (var rule in allShortcuts) {
      if (rule.keySet.keys.length == pressedKeys.length &&
          rule.keySet.keys.every((k) => pressedKeys.contains(k))) {
        return rule;
      }
    }
    return null;
  }
}
