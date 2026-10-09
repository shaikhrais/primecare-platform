/// Shared tenant metadata; branding remains specific to each consumer.
abstract class BasePlatformTenant<TBranding> {
  String get tenantId;
  String get name;
  TBranding get branding;
}
