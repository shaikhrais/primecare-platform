// Governance - Category: model | Purpose: Enterprise data transfer object (DTO) schema contract ensuring payload validity.
import 'package:flutter/widgets.dart';

enum SecurityLevel {
  LOW,
  MEDIUM,
  HIGH,
  CRITICAL
}

enum ShortcutCategory {
  GLOBAL,
  ROLE_SPECIFIC,
  OFFICE_SPECIFIC,
  EMERGENCY,
  ADMIN,
  DEVELOPER,
  CLINICAL,
  FINANCE,
  GOVERNANCE
}

class ShortcutRule {
  final String id;
  final String featureId; // Links to ScreenRegistry or FeatureRegistry
  final ShortcutCategory category;
  final List<String> allowedRoles; // E.g. ['HR_MANAGER', 'SUPER_ADMIN']
  final List<String> allowedOffices; // E.g. ['CORPORATE', 'FRANCHISE']
  final SecurityLevel securityLevel;
  final bool requiresGovernanceApproval;
  final bool requiresOnlineServices;
  final LogicalKeySet keySet;
  final String description;

  const ShortcutRule({
    required this.id,
    required this.featureId,
    required this.category,
    required this.allowedRoles,
    required this.allowedOffices,
    this.securityLevel = SecurityLevel.MEDIUM,
    this.requiresGovernanceApproval = true,
    this.requiresOnlineServices = false,
    required this.keySet,
    required this.description,
  });
}
