import 'package:flutter_core/flutter_core.dart';
import '../automated_audit_engine.dart';

class SecurityAuditor {
  static List<AuditResultItem> audit(List<ScreenMetadata> screens) {
    final results = <AuditResultItem>[];
    
    int securityUnverified = 0;
    int phiComplianceMissing = 0;

    for (final screen in screens) {
      if (!screen.isSecurityVerified) {
        securityUnverified++;
      }
      if (screen.securityLevel == SecurityTier.high && !screen.isPhiCompliant) {
        phiComplianceMissing++;
      }
    }

    results.add(AuditResultItem(
      check: 'Bank-Grade Security Posture',
      result: securityUnverified == 0 ? 'PASSED' : 'FAILED',
      isPass: securityUnverified == 0,
      meaning: securityUnverified == 0 
          ? 'Zero-Trust and device binding enforced across all clinical endpoints.' 
          : '$securityUnverified screens lack active security verification.',
      fix: 'Audit SecurityInterceptor and Trusted Device binding for affected routes.',
    ));

    results.add(AuditResultItem(
      check: 'PHI Compliance Audit',
      result: phiComplianceMissing == 0 ? 'PASSED' : 'FAILED',
      isPass: phiComplianceMissing == 0,
      meaning: phiComplianceMissing == 0 
          ? 'All high-risk data screens are PHI compliant.' 
          : '$phiComplianceMissing high-risk screens lack PHI compliance sign-off.',
      fix: 'Activate ScreenShieldService and verify data masking policies.',
    ));

    return results;
  }
}
