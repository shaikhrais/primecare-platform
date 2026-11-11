// Exact migrated AuditPanel helper, renamed only for behavioral coverage.
import 'package:primecare_ui/primecare_ui.dart';

class PremiumAuditPanelFixture extends StatelessWidget {
  final String modelName;
  final Color themeColor;

  const PremiumAuditPanelFixture({
    required this.modelName,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: theme.colors.outline, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.colors.warning.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: PrimeIcon(Icons.gavel, color: theme.colors.warning, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimeText(
                      'COMPLIANCE & GOVERNANCE', // .tr() LocaleKeys.
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: theme.colors.warning,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      '$modelName Audit Ledger', // .tr() LocaleKeys.
                      style:  TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.colors.onSurface,
                      ),
                    ),
                  ],
                )),
              ],
            ),
            const SizedBox(height: 24),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                PrimeStatusBadge('HIPAA Compliant', tone: PrimeStatusTone.success), // .tr() LocaleKeys.
                PrimeStatusBadge('GDPR Verified', tone: PrimeStatusTone.success), // .tr() LocaleKeys.
                PrimeStatusBadge('TLS 1.3 Active', tone: PrimeStatusTone.success), // .tr() LocaleKeys.
              ],
            ),
            const SizedBox(height: 24),
            PrimeTelemetryRow(
              label: 'Prisma Schema Bindings', // .tr() LocaleKeys.
              value: 'Verified UUID Entity', // .tr() LocaleKeys.
              icon: Icons.dns,
              color: theme.colors.primary,
            ),
            const Divider(height: 24),
            PrimeTelemetryRow(
              label: 'Encryption Standard', // .tr() LocaleKeys.
              value: 'AES-256 GCM', // .tr() LocaleKeys.
              icon: Icons.enhanced_encryption,
              color: theme.colors.secondary,
            ),
            const Divider(height: 24),
            PrimeTelemetryRow(
              label: 'Audit Trail Signature', // .tr() LocaleKeys.
              value: 'SHA-256 HMAC', // .tr() LocaleKeys.
              icon: Icons.fingerprint,
              color: theme.colors.tertiary,
            ),
          ],
        ),
      ),
    );
  }
}
