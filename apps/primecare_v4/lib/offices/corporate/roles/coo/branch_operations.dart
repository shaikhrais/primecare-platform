import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/clinical_glass_panel.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BranchOperationsScreen extends StatelessWidget {
  const BranchOperationsScreen({super.key});

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
                        flex: 5,
                        child: _buildOperationsTable(context),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            _buildIncidentsCard(context),
                            const SizedBox(height: 24),
                            _buildSupplyChainStatus(context),
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
              'Branch Operations',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Monitor daily shift fulfillment, logistics, and supply chain across branches',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
        Row(
          children: [
            _buildActionIconButton(context, LucideIcons.calendar, 'Select Date'),
            const SizedBox(width: 12),
            _buildActionIconButton(context, LucideIcons.filter, 'Filter Branches'),
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
        Expanded(child: _buildKPIUnit(context, 'Global Shift Fulfillment', '94.2%', LucideIcons.users, '-1.2%', Colors.orange)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Open Logistics Tickets', '18', LucideIcons.truck, '+4', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Critical Incidents', '3', LucideIcons.alertTriangle, '-2', Colors.redAccent)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Supply Shortages', '2', LucideIcons.packagePlus, '0', Colors.orange)),
      ],
    );
  }

  Widget _buildKPIUnit(BuildContext context, String title, String value, IconData icon, String trend, Color trendColor) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, color: PrimeCareTheme.emeraldTeal, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: trendColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  trend,
                  style: TextStyle(
                    color: trendColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOperationsTable(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text(
                'Branch Operational Status',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                ),
                ),
                const Icon(LucideIcons.moreHorizontal, color: Colors.white70),
            ],
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
              dataTextStyle: const TextStyle(color: Colors.white),
              columns: const [
                DataColumn(label: Text('Branch')),
                DataColumn(label: Text('Shift Fulfillment')),
                DataColumn(label: Text('Logistics Status')),
                DataColumn(label: Text('Daily Incidents')),
              ],
              rows: [
                _buildDataRow('Toronto Central', '98%', 'On Time', '0', Colors.white, PrimeCareTheme.emeraldTeal),
                _buildDataRow('Vancouver West', '92%', 'Delayed (-30m)', '1', Colors.orange, Colors.orange),
                _buildDataRow('Calgary North', '85%', 'Critical Route', '2', Colors.redAccent, Colors.redAccent),
                _buildDataRow('Montreal Hub', '96%', 'On Time', '0', Colors.white, PrimeCareTheme.emeraldTeal),
                _buildDataRow('Halifax Base', '88%', 'Minor Delay', '1', Colors.orange, Colors.orange),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(String branch, String shift, String logistics, String incidents, Color shiftColor, Color logisticsColor) {
    return DataRow(
      cells: [
        DataCell(Text(branch, style: const TextStyle(fontWeight: FontWeight.w500))),
        DataCell(Text(shift, style: TextStyle(color: shiftColor, fontWeight: FontWeight.bold))),
        DataCell(Text(logistics, style: TextStyle(color: logisticsColor))),
        DataCell(Text(incidents)),
      ],
    );
  }

  Widget _buildIncidentsCard(BuildContext context) {
      return ClinicalGlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(LucideIcons.siren, color: Colors.redAccent, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Critical Incidents',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildIncidentItem('Calgary North', 'Transport Vehicle Breakdown', '1h 15m ago', Colors.redAccent),
            const Divider(color: Colors.white12, height: 32),
            _buildIncidentItem('Vancouver West', 'Emergency Shift Cancellation (Nurse)', '2h 10m ago', Colors.orange),
             const Divider(color: Colors.white12, height: 32),
            _buildIncidentItem('Calgary North', 'Medical Supply Delivery Missing', '3h 45m ago', Colors.orange),
          ],
        ),
      );
  }

    Widget _buildIncidentItem(String location, String issue, String time, Color severity) {
        return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: severity),
                ),
                const SizedBox(width: 12),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(issue, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text('$location • $time', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                        ],
                    ),
                )
            ],
        );
    }

    Widget _buildSupplyChainStatus(BuildContext context) {
      return ClinicalGlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LucideIcons.boxes, color: PrimeCareTheme.emeraldTeal, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Supply Chain Watchlist',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'PPE Level 3 Masks',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                 Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: const LinearProgressIndicator(
                            value: 0.15,
                            backgroundColor: Colors.white12,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                            minHeight: 8,
                        ),
                    ),
                ),
                const SizedBox(width: 12),
                const Text('15% Stock', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Standard Sanitizer Solution',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
               children: [
                 Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: const LinearProgressIndicator(
                            value: 0.35,
                            backgroundColor: Colors.white12,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                            minHeight: 8,
                        ),
                    ),
                ),
                const SizedBox(width: 12),
                const Text('35% Stock', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      );
  }
}
