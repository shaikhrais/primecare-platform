import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_adapters/primecare_adapters.dart';

class ArchitecturalPlanningDashboard extends ConsumerWidget {
  const ArchitecturalPlanningDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ds = PrimeCareDesignSystem.of(context);
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;
    
    final asyncData = ref.watch(architecturePlanningAdapterProvider);

    return PageTemplate(
      title: 'Architectural Governance',
      subtitle: 'Real-time telemetry of the platform\'s strategic mapping across Layers.',
      child: asyncData.when(
        data: (result) {
          final data = result.dataOrNull;
          if (data == null) {
            return const Center(child: Text('Architecture data unavailable'));
          }

          final hasAnomalies = data.flaggedFunctionsWithoutAPIs > 0;
          final statusColor = hasAnomalies ? ds.colors.warning : ds.colors.success;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overall Status
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
                      hasAnomalies ? Icons.warning_amber_rounded : Icons.check_circle,
                      color: statusColor,
                      size: PrimeCareSpacing.scaled(24, scale),
                    ),
                    SizedBox(width: PrimeCareSpacing.scaled(16, scale)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hasAnomalies 
                              ? 'IMPLEMENTATION CONCERNS OBSERVED' 
                              : 'STRUCTURAL PARITY MAINTAINED',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        if (hasAnomalies)
                          Text(
                            '\${data.flaggedFunctionsWithoutAPIs} capabilities lack native API implementation',
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                      ],
                    ),
                    if (data.isOffline) ...[
                      const Spacer(),
                      const Chip(
                        label: Text('OFFLINE CACHE'),
                        backgroundColor: PrimeCareColors.amber,
                        labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ],
                ),
              ),
              if (hasAnomalies && data.missingComponents.isNotEmpty) ...[
                SizedBox(height: PrimeCareSpacing.scaled(24, scale)),
                Text('Pending Implementation Plans', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: statusColor)),
                SizedBox(height: PrimeCareSpacing.scaled(16, scale)),
                for (final missing in data.missingComponents)
                  Card(
                    color: PrimeCareColors.slate800,
                    margin: EdgeInsets.only(bottom: PrimeCareSpacing.scaled(12, scale)),
                    child: ListTile(
                      leading: Icon(Icons.code_off, color: statusColor),
                      title: Text(missing.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: PrimeCareColors.white)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text('Screen: \${missing.screenName} | Route: \${missing.route}', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: PrimeCareColors.amber)),
                          const SizedBox(height: 4),
                          Text(missing.justification, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: PrimeCareColors.slate300)),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  ),
              ],
              SizedBox(height: PrimeCareSpacing.scaled(32, scale)),
              Text('C4 Enterprise Topology', style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: PrimeCareSpacing.scaled(16, scale)),
              
              // Map the C4 Domains
              for (final domain in data.c4Topology) ...[
                Card(
                  margin: EdgeInsets.only(bottom: PrimeCareSpacing.scaled(16, scale)),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.domain, color: ds.colors.primary, size: 28),
                            SizedBox(width: PrimeCareSpacing.scaled(16, scale)),
                            Text(
                              domain.name.toUpperCase(),
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: ds.colors.primary,
                              ),
                            ),
                          ],
                        ),
                        if (domain.description.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            domain.description,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: PrimeCareColors.slate300
                            ),
                          ),
                        ],
                        const Divider(height: 32),
                        Text('Software Systems:', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: PrimeCareColors.slate400)),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: domain.systems.map((sys) => ActionChip(
                            label: Text('\${sys.name} (\${sys.componentsCount} components)'),
                            backgroundColor: PrimeCareColors.slate800,
                            labelStyle: const TextStyle(color: Colors.white),
                            avatar: const Icon(Icons.dns, size: 16, color: PrimeCareColors.white),
                            onPressed: () => _showComponentsBottomSheet(context, sys, ds),
                          )).toList(),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ],
          );
        },
        loading: () => Center(
          child: CircularProgressIndicator(color: ds.colors.primary),
        ),
        error: (err, _) => Center(
          child: Text('Error loading architecture planning data: \$err', style: TextStyle(color: ds.colors.error)),
        ),
      ),
    );
  }


  void _showComponentsBottomSheet(BuildContext context, C4System system, PrimeCareDesignSystem ds) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ds.colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.dns, color: ds.colors.primary, size: 32),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      system.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const Divider(height: 32),
              if (system.components.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No topographical components recorded for this system.', style: TextStyle(color: PrimeCareColors.slate400)),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: system.components.length,
                    itemBuilder: (context, i) {
                      final comp = system.components[i];
                      return Card(
                        color: PrimeCareColors.slate800,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: const Icon(Icons.extension, color: PrimeCareColors.white),
                          title: Text(comp.name, style: const TextStyle(color: PrimeCareColors.white, fontWeight: FontWeight.bold)),
                          subtitle: Text('Status: ${comp.status}', style: const TextStyle(color: PrimeCareColors.amber)),
                          trailing: comp.repoPath != null 
                             ? Icon(Icons.code, color: ds.colors.primary) 
                             : null,
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
