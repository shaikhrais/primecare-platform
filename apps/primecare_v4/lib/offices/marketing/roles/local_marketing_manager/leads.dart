import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class LocalLeadsScreen extends ConsumerStatefulWidget {
  const LocalLeadsScreen({super.key});

  @override
  ConsumerState<LocalLeadsScreen> createState() => _LocalLeadsScreenState();
}

class _LocalLeadsScreenState extends ConsumerState<LocalLeadsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildFunnelOverview(),
            const SizedBox(height: 32),
            Text(
              'Recent Leads',
              style: PrimeCareTheme.typography.h2.copyWith(color: PrimeCareTheme.colors.navyIndigo),
            ),
            const SizedBox(height: 16),
            _buildLeadsTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Local Lead Generation',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Monitor incoming leads from local events and campaigns.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        Row(
          children: [
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.download,
              label: 'Export Data',
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.plus,
              label: 'Manual Entry',
              isActive: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFunnelOverview() {
    return Row(
      children: [
        Expanded(child: _buildFunnelStep(title: 'New Leads', count: 145, percentage: '100%', color: PrimeCareTheme.colors.slateGray)),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Icon(LucideIcons.chevronRight, color: Colors.grey)),
        Expanded(child: _buildFunnelStep(title: 'Contacted', count: 85, percentage: '58%', color: PrimeCareTheme.colors.navyIndigo)),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Icon(LucideIcons.chevronRight, color: Colors.grey)),
        Expanded(child: _buildFunnelStep(title: 'Consultation', count: 42, percentage: '29%', color: PrimeCareTheme.colors.emeraldTeal)),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Icon(LucideIcons.chevronRight, color: Colors.grey)),
        Expanded(child: _buildFunnelStep(title: 'New Patient', count: 28, percentage: '19%', color: PrimeCareTheme.colors.coralRed)),
      ],
    );
  }

  Widget _buildFunnelStep({required String title, required int count, required String percentage, required Color color}) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              title,
              style: PrimeCareTheme.typography.label.copyWith(color: color, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            count.toString(),
            style: PrimeCareTheme.typography.heroTitle.copyWith(color: PrimeCareTheme.colors.navyIndigo),
          ),
          const SizedBox(height: 4),
          Text(
            'Conv. Rate: $percentage',
            style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadsTable() {
    return ClinicalGlassPanel(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildTableHeader(),
          _buildTableRow(name: 'Sarah Jenkins', source: 'Health Fair Booth', date: 'Oct 15, 2026', status: 'New', temperature: 'Hot'),
          Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
          _buildTableRow(name: 'Michael Chang', source: 'Facebook Ad', date: 'Oct 14, 2026', status: 'Contacted', temperature: 'Warm'),
          Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
          _buildTableRow(name: 'Aisha Patel', source: 'Direct/Walk-in', date: 'Oct 12, 2026', status: 'Consultation', temperature: 'Hot'),
          Divider(height: 1, color: PrimeCareTheme.colors.surfaceContainerHighest),
          _buildTableRow(name: 'Robert Davis', source: 'Referral', date: 'Oct 10, 2026', status: 'New Patient', temperature: 'Converted'),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLow,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text('LEAD NAME', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('SOURCE', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('DATE ACQUIRED', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('STATUS', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('TEMPERATURE', style: PrimeCareTheme.typography.label.copyWith(fontSize: 11, color: PrimeCareTheme.colors.slateGray, fontWeight: FontWeight.bold))),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildTableRow({
    required String name,
    required String source,
    required String date,
    required String status,
    required String temperature,
  }) {
    Color tempColor;
    if (temperature == 'Hot' || temperature == 'Converted') {
      tempColor = PrimeCareTheme.colors.coralRed;
    } else if (temperature == 'Warm') {
      tempColor = Colors.amber.shade700;
    } else {
      tempColor = PrimeCareTheme.colors.emeraldTeal; // Cold/Cool
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
                  child: Text(name[0], style: TextStyle(color: PrimeCareTheme.colors.navyIndigo, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                Text(name, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(source, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
          ),
          Expanded(
            flex: 2,
            child: Text(date, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
          ),
          Expanded(
            flex: 2,
            child: Text(status, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Icon(
                  temperature == 'Converted' ? LucideIcons.checkCircle : LucideIcons.flame,
                  size: 16,
                  color: tempColor,
                ),
                const SizedBox(width: 6),
                Text(temperature, style: PrimeCareTheme.typography.body.copyWith(color: tempColor, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(LucideIcons.moreHorizontal, color: PrimeCareTheme.colors.slateGray),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
