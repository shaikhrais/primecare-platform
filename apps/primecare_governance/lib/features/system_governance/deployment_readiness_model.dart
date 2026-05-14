import 'package:primecare_ui/primecare_ui.dart';

enum TargetPlatform { ios, android, web, windows, linux }

class DeploymentReadinessModel {
  final String appName;
  final TargetPlatform platform;
  final bool isReady;

  // Common Meta
  final String title;
  final String fullDescription;
  final String privacyPolicyUrl;
  final String supportUrl;

  // Platform Specific
  final StoreMetadata metadata;

  DeploymentReadinessModel({
    required this.appName,
    required this.platform,
    required this.isReady,
    required this.title,
    required this.fullDescription,
    required this.privacyPolicyUrl,
    required this.supportUrl,
    required this.metadata,
  });
}

abstract class StoreMetadata {
  bool validate();
}

class AppleAppStoreMetadata extends StoreMetadata {
  final String subtitle; // max 30 chars
  final String keywords; // max 100 chars
  final bool hasDemoAccount; // required for review
  final bool hasPrivacyManifest; // required for iOS 17+

  AppleAppStoreMetadata({
    required this.subtitle,
    required this.keywords,
    required this.hasDemoAccount,
    required this.hasPrivacyManifest,
  });

  @override
  bool validate() => subtitle.length <= 30 && keywords.length <= 100 && hasDemoAccount && hasPrivacyManifest;
}

class GooglePlayStoreMetadata extends StoreMetadata {
  final String shortDescription; // max 80 chars
  final bool hasFeatureGraphic; // 1024x500 px
  final bool dataSafetyFormCompleted;

  GooglePlayStoreMetadata({
    required this.shortDescription,
    required this.hasFeatureGraphic,
    required this.dataSafetyFormCompleted,
  });

  @override
  bool validate() => shortDescription.length <= 80 && hasFeatureGraphic && dataSafetyFormCompleted;
}

class WindowsStoreMetadata extends StoreMetadata {
  final String packageIdentity; // must match Partner Center
  final String publisherDisplayName;
  final bool hasMsixBundle;

  WindowsStoreMetadata({
    required this.packageIdentity,
    required this.publisherDisplayName,
    required this.hasMsixBundle,
  });

  @override
  bool validate() => packageIdentity.isNotEmpty && publisherDisplayName.isNotEmpty && hasMsixBundle;
}

class LinuxAppStreamMetadata extends StoreMetadata {
  final String appStreamId; // e.g. org.example.MyApp
  final bool hasMetainfoXml; // Validated via appstreamcli
  final String spdxLicense;

  LinuxAppStreamMetadata({
    required this.appStreamId,
    required this.hasMetainfoXml,
    required this.spdxLicense,
  });

  @override
  bool validate() => appStreamId.isNotEmpty && hasMetainfoXml && spdxLicense.isNotEmpty;
}

class WebDeploymentMetadata extends StoreMetadata {
  final String seoTitle;
  final String metaDescription;
  final bool hasPwaManifest;
  final bool hasServiceWorker;

  WebDeploymentMetadata({
    required this.seoTitle,
    required this.metaDescription,
    required this.hasPwaManifest,
    required this.hasServiceWorker,
  });

  @override
  bool validate() => seoTitle.isNotEmpty && metaDescription.isNotEmpty && hasPwaManifest;
}
