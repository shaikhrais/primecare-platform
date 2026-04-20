import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

import 'package:primecare_adapters/primecare_adapters.dart';

class VerificationHub extends ConsumerWidget {
  const VerificationHub({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ds = PrimeCareDesignSystem.of(context);
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;
    
    final asyncVerification = ref.watch(systemVerificationAdapterProvider);

    return PageTemplate(
      title: 'Verification Hub',
      subtitle: 'System integrity and macro-reconciliation telemetry logs',
      child: asyncVerification.when(
        data: (result) {
          final data = result.dataOrNull;
          if (data == null) {
            return const Center(child: Text('Verification data unavailable'));
          }

          final statusColor = data.status == 'connected' 
              ? ds.colors.success 
              : (data.status == 'offline' ? ds.colors.warning : ds.colors.error);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(PrimeCareSpacing.scaled(16, scale)),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  border: Border.all(color: statusColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      data.status == 'connected' ? Icons.check_circle : Icons.warning_amber_rounded,
                      color: statusColor,
                      size: PrimeCareSpacing.scaled(24, scale),
                    ),
                    SizedBox(width: PrimeCareSpacing.scaled(16, scale)),
                    Text(
                      'Database Status: ${data.status.toUpperCase()}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: statusColor),
                    ),
                    if (data.isOffline) ...[
                      const Spacer(),
                      const Chip(
                        label: Text('OFFLINE FALLBACK'),
                        backgroundColor: PrimeCareColors.amber,
                        labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: PrimeCareSpacing.scaled(32, scale)),
              Text('Table Row Counts', style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: PrimeCareSpacing.scaled(16, scale)),
              PrimeResponsiveGrid(
                desktopMainAxisExtent: PrimeCareSpacing.scaled(160, scale),
                children: data.modelCounts.entries.map<Widget>((entry) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.table_chart_outlined, size: 32, color: PrimeCareColors.slate400),
                          const SizedBox(height: 8),
                          Text(entry.key, style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 4),
                          Text(entry.value.toString(), style: Theme.of(context).textTheme.titleLarge),
                        ],
                      )
                    )
                  );
                }).toList(),
              ),
            ],
          );
        },
        loading: () => Center(
          child: CircularProgressIndicator(color: ds.colors.primary),
        ),
        error: (err, _) => Center(
          child: Text('Error loading verification logs: $err', style: TextStyle(color: ds.colors.error)),
        ),
      ),
    );
  }
}
