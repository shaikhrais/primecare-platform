// Governance - Category: service | Purpose: Core implementation file for the Growth Pipeline platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class GrowthPipelineState {
  final List<Map<String, dynamic>> leads;
  final String searchQuery;
  final String activeStageFilter;
  final double minCapitalFilter;
  final String? selectedLeadId;
  final bool isAnalyzingTerritory;

  const GrowthPipelineState({
    required this.leads,
    required this.searchQuery,
    required this.activeStageFilter,
    required this.minCapitalFilter,
    this.selectedLeadId,
    required this.isAnalyzingTerritory,
  });

  GrowthPipelineState copyWith({
    List<Map<String, dynamic>>? leads,
    String? searchQuery,
    String? activeStageFilter,
    double? minCapitalFilter,
    String? selectedLeadId,
    bool? isAnalyzingTerritory,
  }) {
    return GrowthPipelineState(
      leads: leads ?? this.leads,
      searchQuery: searchQuery ?? this.searchQuery,
      activeStageFilter: activeStageFilter ?? this.activeStageFilter,
      minCapitalFilter: minCapitalFilter ?? this.minCapitalFilter,
      selectedLeadId: selectedLeadId ?? this.selectedLeadId,
      isAnalyzingTerritory: isAnalyzingTerritory ?? this.isAnalyzingTerritory,
    );
  }
}

// --- Controller ---
class GrowthPipelineController extends StateNotifier<GrowthPipelineState> {
  final Ref _ref;

  GrowthPipelineController(this._ref)
      : super(
          const GrowthPipelineState(
            leads: [
              {
                'id': 'LD-901',
                'name': 'Dr. Sarah Jenkins',
                'territory': 'North Vancouver, BC',
                'stage': 'Under Review',
                'capital': 350000.00,
                'rating': 4.8,
                'experience': '12 years Medical Group Practice Lead',
                'notes': 'Strong financial backing, excellent clinical alignment.',
              },
              {
                'id': 'LD-902',
                'name': 'Marcus Vance',
                'territory': 'Oakville, ON',
                'stage': 'Approved / Signing',
                'capital': 500000.00,
                'rating': 4.9,
                'experience': 'Multi-unit QSR Franchisee Owner',
                'notes': 'Veteran operator, requested Oakville South territory.',
              },
              {
                'id': 'LD-903',
                'name': 'Elena Rostova',
                'territory': 'Calgary South, AB',
                'stage': 'New Lead',
                'capital': 250000.00,
                'rating': 4.2,
                'experience': 'Senior Care Facility Administrator',
                'notes': 'Clinical background is ideal. Needs capital validation check.',
              },
              {
                'id': 'LD-904',
                'name': 'Arthur Pendelton',
                'territory': 'Halifax, NS',
                'stage': 'Interview Scheduled',
                'capital': 300000.00,
                'rating': 4.5,
                'experience': 'Home Healthcare Agency Executive',
                'notes': 'Excellent regulatory relationships in Nova Scotia.',
              },
              {
                'id': 'LD-905',
                'name': 'Diana Prince',
                'territory': 'Victoria Central, BC',
                'stage': 'Under Review',
                'capital': 180000.00,
                'rating': 3.9,
                'experience': 'Registered Nurse Team Lead',
                'notes': 'Highly passionate clinical experience, searching for a capital partner.',
              },
            ],
            searchQuery: '',
            activeStageFilter: 'all',
            minCapitalFilter: 0.0,
            isAnalyzingTerritory: false,
          ),
        );

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateStageFilter(String stage) {
    state = state.copyWith(activeStageFilter: stage);
  }

  void updateMinCapitalFilter(double val) {
    state = state.copyWith(minCapitalFilter: val);
  }

  void selectLead(String? id) {
    state = state.copyWith(selectedLeadId: id);

    if (id != null) {
      try {
        _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
              route: '/generated/growth_pipeline',
              eventType: 'franchise_lead_interaction',
              metadata: {
                'lead_id': id,
                'action': 'select_details',
                'timestamp': DateTime.now().toIso8601String(),
              },
            );
      } catch (_) {}
    }
  }

  void requestTerritoryStudy(String leadId) {
    state = state.copyWith(isAnalyzingTerritory: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/growth_pipeline',
            eventType: 'franchise_territory_analysis_triggered',
            metadata: {
              'lead_id': leadId,
              'timestamp': DateTime.now().toIso8601String(),
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 1500), () {
      state = state.copyWith(isAnalyzingTerritory: false);
    });
  }

  void advanceStage(String leadId) {
    final updated = state.leads.map((lead) {
      if (lead['id'] == leadId) {
        String nextStage = (lead['stage'] as String);
        if (lead['stage'] == 'New Lead') {
          nextStage = 'Under Review';
        } else if (lead['stage'] == 'Under Review') {
          nextStage = 'Interview Scheduled';
        } else if (lead['stage'] == 'Interview Scheduled') {
          nextStage = 'Approved / Signing';
        }
        return {
          ...lead,
          'stage': nextStage,
        };
      }
      return lead;
    }).toList();

    state = state.copyWith(leads: updated);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/growth_pipeline',
            eventType: 'franchise_lead_advanced',
            metadata: {
              'lead_id': leadId,
              'timestamp': DateTime.now().toIso8601String(),
            },
          );
    } catch (_) {}
  }
}

// --- Provider ---
final growthPipelineControllerProvider =
    StateNotifierProvider<GrowthPipelineController, GrowthPipelineState>((ref) {
  return GrowthPipelineController(ref);
});

// --- View ---
class GrowthPipeline extends GovernedConsumerWidget {
  const GrowthPipeline({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(growthPipelineControllerProvider);
    final controller = ref.read(growthPipelineControllerProvider.notifier);
    final theme = context.theme;

    // Filter leads
    final filteredLeads = state.leads.where((lead) {
      final matchesSearch = (lead['name'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (lead['territory'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (lead['id'] as String).toLowerCase().contains(state.searchQuery.toLowerCase());
      final matchesStage = state.activeStageFilter == 'all' ||
          (lead['stage'] as String).toLowerCase() == state.activeStageFilter.toLowerCase();
      final matchesCapital = (lead['capital'] as double) >= state.minCapitalFilter;
      return matchesSearch && matchesStage && matchesCapital;
    }).toList();

    // Pipeline aggregate values
    double totalCapital = 0;
    int signingCount = 0;
    int reviewCount = 0;
    for (final lead in state.leads) {
      totalCapital += lead['capital'] as double;
      if (lead['stage'] == 'Approved / Signing') {
        signingCount++;
      } else if (lead['stage'] == 'Under Review') {
        reviewCount++;
      }
    }

    final selectedLead = state.selectedLeadId == null
        ? null
        : state.leads.firstWhere((l) => l['id'] == state.selectedLeadId);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.globe, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'CEO Expansion Command Center',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Franchise Growth & Territories',
                          style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Evaluate franchisee applicants, review investment capital deployment, and authorize regional license agreements.',
                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Aggregates Grid
                Row(
                  children: [
                    Expanded(
                      child: _SummaryCard(
                        title: 'Pipeline Capital Volume',
                        value: '\$${(totalCapital / 1000).toStringAsFixed(0)}K',
                        icon: LucideIcons.wallet,
                        accentColor: theme.colors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _SummaryCard(
                        title: 'Approved for Signing',
                        value: '$signingCount Deals',
                        icon: LucideIcons.fileSignature,
                        accentColor: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _SummaryCard(
                        title: 'Under Strategic Review',
                        value: '$reviewCount Leads',
                        icon: LucideIcons.search,
                        accentColor: Colors.amber,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Controls Filter Box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search by franchisee name, ID, or territory...',
                                prefixIcon: const Icon(LucideIcons.search, size: 20),
                                fillColor: theme.colors.background,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(theme.radiusMd),
                                  borderSide: BorderSide(color: theme.colors.border),
                                ),
                              ),
                              onChanged: controller.updateSearch,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Wrap(
                            spacing: 8,
                            children: [
                              _FilterTab(
                                label: 'All',
                                value: 'all',
                                activeValue: state.activeStageFilter,
                                onTap: controller.updateStageFilter,
                              ),
                              _FilterTab(
                                label: 'New',
                                value: 'new lead',
                                activeValue: state.activeStageFilter,
                                onTap: controller.updateStageFilter,
                              ),
                              _FilterTab(
                                label: 'In Review',
                                value: 'under review',
                                activeValue: state.activeStageFilter,
                                onTap: controller.updateStageFilter,
                              ),
                              _FilterTab(
                                label: 'Signing',
                                value: 'approved / signing',
                                activeValue: state.activeStageFilter,
                                onTap: controller.updateStageFilter,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(LucideIcons.dollarSign, size: 18, color: theme.colors.onSurfaceVariant),
                          const SizedBox(width: 12),
                          Text(
                            'Min Available Capital: \$${(state.minCapitalFilter / 1000).toStringAsFixed(0)}K',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Slider(
                              value: state.minCapitalFilter,
                              min: 0.0,
                              max: 600000.0,
                              divisions: 12,
                              activeColor: theme.colors.primary,
                              onChanged: controller.updateMinCapitalFilter,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Lead List Grid
                Expanded(
                  child: filteredLeads.isEmpty
                      ? Center(
                          child: Text(
                            'No franchise leads matching the active selection criteria.',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredLeads.length,
                          itemBuilder: (context, index) {
                            final lead = filteredLeads[index];
                            final leadId = lead['id'] as String;
                            final capital = lead['capital'] as double;
                            final stage = lead['stage'] as String;

                            Color stageColor = Colors.grey;
                            if (stage == 'Approved / Signing') {
                              stageColor = Colors.green;
                            } else if (stage == 'Under Review') {
                              stageColor = Colors.amber;
                            } else if (stage == 'Interview Scheduled') {
                              stageColor = theme.colors.primary;
                            } else if (stage == 'New Lead') {
                              stageColor = Colors.blue;
                            }

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: theme.colors.surface,
                                borderRadius: BorderRadius.circular(theme.radiusMd),
                                border: Border.all(color: theme.colors.border),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: stageColor.withValues(alpha: 0.1),
                                    child: Icon(
                                      stage == 'Approved / Signing'
                                          ? LucideIcons.fileSignature
                                          : LucideIcons.user,
                                      color: stageColor,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              (lead['name'] as String),
                                              style: theme.typography.h4.copyWith(
                                                color: theme.colors.onSurface,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: stageColor.withValues(alpha: 0.15),
                                                borderRadius: BorderRadius.circular(theme.radiusSm),
                                              ),
                                              child: Text(
                                                stage,
                                                style: theme.typography.bodySmall.copyWith(
                                                  color: stageColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Requested Territory: ${lead['territory']}',
                                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Background: ${lead['experience']}',
                                          style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '\$${(capital / 1000).toStringAsFixed(0)}K Available',
                                        style: theme.typography.bodyLarge.copyWith(
                                          color: theme.colors.onSurface,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: () => controller.selectLead(leadId),
                                            child: const Text('Details'),
                                          ),
                                          const SizedBox(width: 8),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: theme.colors.primary,
                                              foregroundColor: theme.colors.onPrimary,
                                            ),
                                            onPressed: () => controller.advanceStage(leadId),
                                            child: const Icon(LucideIcons.arrowRight, size: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),

          // Territory Viability Drawer / Sheet
          if (selectedLead != null)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 380,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colors.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(-2, 0),
                    ),
                  ],
                  border: Border(left: BorderSide(color: theme.colors.border)),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Franchise Details',
                          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                        ),
                        IconButton(
                          icon: const Icon(LucideIcons.x),
                          onPressed: () => controller.selectLead(null),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(
                      (selectedLead['name'] as String),
                      style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                    ),
                    Text(
                      'Target Market: ${selectedLead['territory']}',
                      style: theme.typography.bodyLarge.copyWith(color: theme.colors.primary),
                    ),
                    const SizedBox(height: 20),
                    _InfoRow(label: 'Applicant ID', value: (selectedLead['id'] as String)),
                    _InfoRow(label: 'Operator Background', value: (selectedLead['experience'] as String)),
                    _InfoRow(label: 'Capital Guarantee', value: '\$${(selectedLead['capital'] as double).toStringAsFixed(2)}'),
                    _InfoRow(label: 'Strategic Score', value: '${selectedLead['rating']} / 5.0'),
                    const SizedBox(height: 16),
                    Text(
                      'Evaluator Internal Notes:',
                      style: theme.typography.bodyMedium.copyWith(
                        color: theme.colors.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colors.background,
                        borderRadius: BorderRadius.circular(theme.radiusSm),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Text(
                        (selectedLead['notes'] as String),
                        style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Market Demographics (Simulated)',
                      style: theme.typography.bodyMedium.copyWith(
                        color: theme.colors.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _InfoRow(label: 'Senior Care Density', value: 'High (84th Percentile)'),
                    _InfoRow(label: 'Est. Operating Margins', value: '24.5% - 28.2%'),
                    const SizedBox(height: 24),
                    const Spacer(),
                    if (state.isAnalyzingTerritory)
                      const Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 12),
                            Text('Analyzing geographic feasibility...'),
                          ],
                        ),
                      )
                    else ...[
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: OutlinedButton(
                          onPressed: () => controller.requestTerritoryStudy((selectedLead['id'] as String)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(LucideIcons.map, size: 18, color: theme.colors.primary),
                              const SizedBox(width: 8),
                              const Text('Run Territory Feasibility study'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            controller.advanceStage((selectedLead['id'] as String));
                            controller.selectLead(null);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Lead advanced and saved to compliance sweeps!')),
                            );
                          },
                          child: const Text('Approve Territory License'),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color accentColor;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: accentColor.withValues(alpha: 0.1),
            child: Icon(icon, color: accentColor),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.typography.h2.copyWith(
                  color: theme.colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterTab extends StatelessWidget {
  final String label;
  final String value;
  final String activeValue;
  final ValueChanged<String> onTap;

  const _FilterTab({
    required this.label,
    required this.value,
    required this.activeValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isActive = value.toLowerCase() == activeValue.toLowerCase();
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? theme.colors.primary : theme.colors.background,
          borderRadius: BorderRadius.circular(theme.radiusSm),
          border: Border.all(
            color: isActive ? theme.colors.primary : theme.colors.border,
          ),
        ),
        child: Text(
          label,
          style: theme.typography.bodySmall.copyWith(
            color: isActive ? theme.colors.onPrimary : theme.colors.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: theme.typography.bodyMedium.copyWith(
              color: theme.colors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
