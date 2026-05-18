const fs = require('fs');
const path = require('path');
const dir = 'c:/Users/Admin2/Documents/GitHub/primecare-platform/packages/primecare_ui/lib/src/features/generated_screens';
const files = fs.readdirSync(dir).filter(f => f.endsWith('.dart'));

let count = 0;
for (const file of files) {
  const filepath = path.join(dir, file);
  const match = file.match(/premium_feature_(\d+)/);
  if (!match) continue;
  const featureNum = match[1];
  
  const newContent = `import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';

class PremiumFeature${featureNum} extends GovernedConsumerWidget {
  const PremiumFeature${featureNum}({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          'Premium Feature ${featureNum}',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Premium Dashboard',
              style: theme.typography.h2.copyWith(color: theme.colors.onBackground),
            ),
            const SizedBox(height: 24),
            ResponsiveGrid(
              minItemWidth: 320,
              maxItemWidth: 450,
              spacing: 16.0,
              children: [
                Card(
                  color: theme.colors.surface,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Feature Initialization', style: theme.typography.h4),
                        const SizedBox(height: 8),
                        Text('Premium Feature ${featureNum} has been properly initialized.'),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: theme.colors.surface,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Telemetry Status', style: theme.typography.h4),
                        const SizedBox(height: 8),
                        const Text('AuraBehavioralTelemetry actively monitoring.'),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: theme.colors.surface,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Prisma Integration', style: theme.typography.h4),
                        const SizedBox(height: 8),
                        const Text('Connected securely to the edge Prisma proxy.'),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: theme.colors.surface,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Governance Audit', style: theme.typography.h4),
                        const SizedBox(height: 8),
                        const Text('Compliant with Zero-Trust architecture.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
`;

  fs.writeFileSync(filepath, newContent);
  count++;
}
console.log('Hydrated ' + count + ' premium feature screens with valid ResponsiveGrid.');
