import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

/// [Layout] - The master shell for all PrimeCare Dashboards.
/// Inherits from [GovernanceMasterLayout] to enforce platform-wide structural consistency,
/// dynamic theme styling, and "Zero-Trust" security gates.
class MasterLayout extends GovernanceMasterLayout {
  const MasterLayout({
    super.key,
    required super.application,
    required super.activeRole,
    required super.child,
  });
}
