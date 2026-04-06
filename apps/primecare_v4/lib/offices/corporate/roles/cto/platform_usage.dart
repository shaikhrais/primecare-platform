import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/clinical_glass_panel.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PlatformUsageScreen extends StatelessWidget {
  const PlatformUsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                   _buildKPIs(context),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                            children: [
                                _buildConcurrencyChart(context),
                                const SizedBox(height: 24),
                                _buildActiveSessionsList(context),
                            ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildStorageUtilization(context),
                            const SizedBox(height: 24),
                            _buildCapacityForecast(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Platform Usage & Capacity',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Monitor concurrency, active sessions, storage tiers, and capacity planning.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
        Row(
          children: [
            _buildActionIconButton(context, LucideIcons.cloudRain, 'Scale Tiers'),
            const SizedBox(width: 12),
            _buildActionIconButton(context, LucideIcons.download, 'Export Usage'),
          ],
        ),
      ],
    );
  }

  Widget _buildActionIconButton(BuildContext context, IconData icon, String tooltip) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: () {},
        tooltip: tooltip,
      ),
    );
  }

  Widget _buildKPIs(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildKPIUnit(context, 'Peak Concurrency', '4,280', LucideIcons.users, 'Users/min', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Total Storage Used', '14.2 TB', LucideIcons.database, '78% of provisioned', Colors.orange)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'MAU', '124.5k', LucideIcons.activity, '+12% MoM', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Est. Capacity Headroom', '6.5 Mo', LucideIcons.calendar, 'Before auto-scale', Colors.blue)),
      ],
    );
  }

  Widget _buildKPIUnit(BuildContext context, String title, String value, IconData icon, String subtitle, Color color) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
                color: color.withValues(alpha: 0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
            ),
           )
        ],
      ),
    );
  }

    Widget _buildConcurrencyChart(BuildContext context) {
      return ClinicalGlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Text(
                  '24h Concurrency Timeline',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                  ),
                  ),
                   Text('Filter by Region', style: TextStyle(color: Colors.blueAccent, fontSize: 13, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 32),
            Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.02),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                ),
                child: const Center(child: Text('[Concurrency Spline Chart Placeholder]', style: TextStyle(color: Colors.white38))),
            )
          ],
        ),
      );
    }

    Widget _buildActiveSessionsList(BuildContext context) {
         return ClinicalGlassPanel(
            padding: const EdgeInsets.all(24),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Text(
                        'Active Session Distribution',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                        ),
                     ),
                    const SizedBox(height: 24),
                    _buildSessionRow('US East (N. Virginia)', 1845, 0.45, PrimeCareTheme.emeraldTeal),
                    const SizedBox(height: 16),
                    _buildSessionRow('US West (Oregon)', 1220, 0.30, PrimeCareTheme.emeraldTeal),
                    const SizedBox(height: 16),
                    _buildSessionRow('EU Central (Frankfurt)', 840, 0.20, Colors.blueAccent),
                    const SizedBox(height: 16),
                    _buildSessionRow('AP South (Mumbai)', 375, 0.05, Colors.orange),
                ]
            )
        );
    }

    Widget _buildSessionRow(String region, int sessions, double fraction, Color color) {
         return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                 Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                         Text(region, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                         Text('$sessions', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                     ]
                 ),
                 const SizedBox(height: 8),
                 LinearProgressIndicator(
                     value: fraction,
                     backgroundColor: Colors.white12,
                     valueColor: AlwaysStoppedAnimation<Color>(color),
                     minHeight: 6,
                 ),
             ]
         );
    }

    Widget _buildStorageUtilization(BuildContext context) {
      return ClinicalGlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                 Text(
                  'Storage Tier Utilization',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            const SizedBox(height: 24),
            _buildStorageTier('Hot (SSD)', '4.2 TB', '6.0 TB', 0.70, Colors.redAccent),
            const SizedBox(height: 20),
            _buildStorageTier('Warm (HDD)', '8.1 TB', '10.0 TB', 0.81, Colors.orange),
             const SizedBox(height: 20),
            _buildStorageTier('Cold (Glacier)', '1.9 TB', 'Unlimited', 0.1, PrimeCareTheme.emeraldTeal), // Just a visual proxy
          ],
        ),
      );
    }

    Widget _buildStorageTier(String name, String used, String total, double fill, Color color) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                         Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                         Text('$used / $total', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                    ]
                ),
                const SizedBox(height: 8),
                ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                         value: fill,
                         backgroundColor: Colors.white12,
                         valueColor: AlwaysStoppedAnimation<Color>(color),
                         minHeight: 8,
                    )
                )
            ]
        );
    }

    Widget _buildCapacityForecast(BuildContext context) {
         return ClinicalGlassPanel(
            padding: const EdgeInsets.all(24),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Row(
                        children: [
                            Icon(LucideIcons.trendingUp, color: PrimeCareTheme.emeraldTeal, size: 24),
                            const SizedBox(width: 12),
                            Text(
                            'Capacity Forecaster',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                            ),
                            ),
                        ],
                    ),
                    const SizedBox(height: 24),
                    const Text('Predicted threshold crossing for Database Compute tier (R5.4xlarge) based on current linear growth vector.', style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4)),
                    const SizedBox(height: 16),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            const Text('Est. Crossing Date:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                            Text('Nov 15, 2026', style: TextStyle(color: Colors.orange.shade300, fontWeight: FontWeight.bold, fontSize: 16)),
                        ]
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(color: PrimeCareTheme.emeraldTeal.withValues(alpha: 0.5)),
                                foregroundColor: PrimeCareTheme.emeraldTeal,
                            ),
                            child: const Text('Provision Next Tier Now'),
                        )
                    )
                ]
            )
        );
    }

}
