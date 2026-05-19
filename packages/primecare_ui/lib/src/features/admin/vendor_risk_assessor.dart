import 'package:primecare_ui/primecare_ui.dart';

final vendorRiskProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/compliance/vendor-risk');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class VendorRiskAssessorScreen extends GovernedConsumerWidget {
  const VendorRiskAssessorScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(vendorRiskProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Vendor Risk Assessor',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(vendorRiskProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load vendor risk data: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (vendors) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Third-Party Vendor Compliance', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: ResponsiveGrid(
                  minItemWidth: 350,
                  spacing: 24,
                  children: vendors.map((vendor) {
                    final riskLevel = vendor['riskLevel'] as String? ?? 'low';
                    Color riskColor;
                    if (riskLevel == 'high' || riskLevel == 'critical') {
                      riskColor = theme.colors.error;
                    } else if (riskLevel == 'medium') {
                      riskColor = theme.colors.warning;
                    } else {
                      riskColor = theme.colors.success;
                    }

                    return Card(
                      color: theme.colors.surface,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(vendor['name'] as String? ?? 'Unknown Vendor', style: theme.typography.h3),
                                Icon(Icons.business_center, color: theme.colors.primary),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text('Service: ${vendor['serviceType'] ?? 'N/A'}', style: theme.typography.bodyMedium),
                            const SizedBox(height: 8),
                            Text('Last Audit: ${vendor['lastAudit'] ?? 'N/A'}', style: theme.typography.labelSmall.copyWith(color: theme.colors.textSecondary)),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Risk Level:', style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                                Chip(
                                  label: Text(riskLevel.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  backgroundColor: riskColor.withOpacity(0.2),
                                  side: BorderSide(color: riskColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
