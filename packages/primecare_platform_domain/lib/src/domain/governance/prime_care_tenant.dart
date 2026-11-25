part of '../../../models/domain_governance.dart';

/// Canonical implementation of the PrimeCare Tenant.
class PrimeCareTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_hq';

  @override
  String get name => 'PrimeCare';

  @override
  ThemeData get branding => ThemeData.light();
}
