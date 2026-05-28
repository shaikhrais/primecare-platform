// Governance - Category: service | Purpose: Core implementation file for the Policy Manager platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- Domain Entity ---
class RegulatoryPolicy {
  final String id;
  final String title;
  final String version;
  final String category; // HIPAA, Clinical, Administrative
  final DateTime lastReviewed;
  final String status; // Active, Draft, Archived
  final int signoffCount;
  final int targetSignoffs;

  const RegulatoryPolicy({
    required this.id,
    required this.title,
    required this.version,
    required this.category,
    required this.lastReviewed,
    required this.status,
    required this.signoffCount,
    required this.targetSignoffs,
  });

  RegulatoryPolicy copyWith({
    String? status,
    int? signoffCount,
  }) {
    return RegulatoryPolicy(
      id: id,
      title: title,
      version: version,
      category: category,
      lastReviewed: lastReviewed,
      status: status ?? this.status,
      signoffCount: signoffCount ?? this.signoffCount,
      targetSignoffs: targetSignoffs,
    );
  }
}

// --- State Model ---
class PolicyState {
  final bool isLoading;
  final List<RegulatoryPolicy> policies;
  final String searchQuery;
  final String selectedCategory; // 'All', 'HIPAA', 'Clinical', 'Administrative'

  const PolicyState({
    required this.isLoading,
    required this.policies,
    required this.searchQuery,
    required this.selectedCategory,
  });

  PolicyState copyWith({
    bool? isLoading,
    List<RegulatoryPolicy>? policies,
    String? searchQuery,
    String? selectedCategory,
  }) {
    return PolicyState(
      isLoading: isLoading ?? this.isLoading,
      policies: policies ?? this.policies,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

// --- Controller (Notifier) ---
class PolicyController extends StateNotifier<PolicyState> {
  PolicyController()
      : super(
          PolicyState(
            isLoading: false,
            searchQuery: '',
            selectedCategory: 'All',
            policies: [
              RegulatoryPolicy(
                id: 'SOP-201',
                title: 'Clinical Medication Administration Guidelines',
                version: 'v4.2',
                category: 'Clinical',
                lastReviewed: DateTime.now().subtract(const Duration(days: 34)),
                status: 'Active',
                signoffCount: 182,
                targetSignoffs: 210,
              ),
              RegulatoryPolicy(
                id: 'SOP-202',
                title: 'HIPAA Information Privacy and Telemetry Rules',
                version: 'v5.0',
                category: 'HIPAA',
                lastReviewed: DateTime.now().subtract(const Duration(days: 12)),
                status: 'Active',
                signoffCount: 198,
                targetSignoffs: 210,
              ),
              RegulatoryPolicy(
                id: 'SOP-203',
                title: 'Administrative Caregiver Dispatch Logistics',
                version: 'v1.1',
                category: 'Administrative',
                lastReviewed: DateTime.now().subtract(const Duration(days: 180)),
                status: 'Draft',
                signoffCount: 12,
                targetSignoffs: 50,
              ),
            ],
          ),
        );

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  void toggleStatus(String id) {
    state = state.copyWith(
      policies: state.policies.map((p) {
        if (p.id == id) {
          final nextStatus = p.status == 'Active' ? 'Draft' : 'Active';
          return p.copyWith(status: nextStatus);
        }
        return p;
      }).toList(),
    );
  }

  Future<void> triggerSignoffCampaign(String id) async {
    state = state.copyWith(
      policies: state.policies.map((p) {
        if (p.id == id) {
          // Increase signatures to simulate a campaign
          final nextSignoffs = (p.signoffCount + 12).clamp(0, p.targetSignoffs);
          return p.copyWith(signoffCount: nextSignoffs);
        }
        return p;
      }).toList(),
    );
  }
}

// --- Provider ---
final policyProvider = StateNotifierProvider<PolicyController, PolicyState>((ref) {
  return PolicyController();
});

// --- View ---
class PolicyManager extends GovernedConsumerWidget {
  const PolicyManager({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(policyProvider);
    final controller = ref.read(policyProvider.notifier);
    final theme = context.theme;

    // Filter policies
    final filteredPolicies = state.policies.where((p) {
      final matchesSearch = p.title.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          p.id.toLowerCase().contains(state.searchQuery.toLowerCase());
      final matchesCat = state.selectedCategory == 'All' || p.category == state.selectedCategory;
      return matchesSearch && matchesCat;
    }).toList();

    return Scaffold(
      backgroundColor: theme.colors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GovDashboardHero(
              title: 'Regulatory Policy SOP Manager',
              roleName: 'Standards Compliance',
              description: 'Manage standard operating procedures, track regulatory HIPAA alignment, and trigger caregiver signature verification campaigns.',
              onRefresh: () {},
            ),
            const SizedBox(height: 24),

            // Search and Category Chips
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: theme.colors.border),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(key: const Key('policy_manager_textfield_input_1'), 
                      decoration: const InputDecoration(
                        icon: Icon(LucideIcons.search, size: 20),
                        hintText: 'Search SOP Title or ID...',
                        border: InputBorder.none,
                      ),
                      onChanged: controller.updateSearch,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Row(
                  children: ['All', 'HIPAA', 'Clinical', 'Administrative'].map((cat) {
                    final isSelected = state.selectedCategory == cat;
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ChoiceChip(
                        label: Text(cat),
                        selected: isSelected,
                        selectedColor: theme.colors.primary.withOpacity(0.2),
                        backgroundColor: theme.colors.surface,
                        labelStyle: TextStyle(
                          color: isSelected ? theme.colors.primary : theme.colors.onSurfaceVariant,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        onSelected: (val) {
                          if (val) controller.setCategory(cat);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Policy Catalog Cards
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                mainAxisExtent: 260,
              ),
              itemCount: filteredPolicies.length,
              itemBuilder: (context, index) {
                final policy = filteredPolicies[index];
                final signoffPercent = policy.signoffCount / policy.targetSignoffs;
                final isActive = policy.status == 'Active';

                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: theme.colors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              policy.id,
                              style: TextStyle(
                                color: theme.colors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Switch(
                            value: isActive,
                            activeColor: Colors.green,
                            onChanged: (val) => controller.toggleStatus(policy.id),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        policy.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Category: ${policy.category} | Version: ${policy.version}',
                        style: theme.typography.labelSmall.copyWith(color: theme.colors.onSurfaceVariant),
                      ),
                      const Spacer(),
                      Divider(color: theme.colors.border),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Read-Signoffs Collected',
                            style: theme.typography.labelSmall,
                          ),
                          Text(
                            '${policy.signoffCount}/${policy.targetSignoffs} (${(signoffPercent * 100).toStringAsFixed(0)}%)',
                            style: theme.typography.labelSmall.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: signoffPercent,
                          backgroundColor: theme.colors.background,
                          valueColor: AlwaysStoppedAnimation(
                            signoffPercent >= 0.9 ? Colors.green : theme.colors.primary,
                          ),
                          minHeight: 6,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 36,
                        child: OutlinedButton(key: const Key('policy_manager_outlinedbutton_button_1'), 
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: theme.colors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: () {
                            controller.triggerSignoffCampaign(policy.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Triggered staff notification ping for policy ${policy.id}.'),
                                backgroundColor: theme.colors.primary,
                              ),
                            );
                          },
                          child: Text(
                            'Trigger Signoff Ping',
                            style: TextStyle(color: theme.colors.primary, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
