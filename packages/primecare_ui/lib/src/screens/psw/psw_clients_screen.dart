// Governance - Category: view | Purpose: UI Screen component rendering the Psw Clients Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class PswClientsState {
  final List<Map<String, dynamic>> clients;
  final String searchQuery;
  final String activeFilter; // 'all', 'today', 'pending'

  const PswClientsState({
    required this.clients,
    this.searchQuery = '',
    this.activeFilter = 'all',
  });

  PswClientsState copyWith({
    List<Map<String, dynamic>>? clients,
    String? searchQuery,
    String? activeFilter,
  }) {
    return PswClientsState(
      clients: clients ?? this.clients,
      searchQuery: searchQuery ?? this.searchQuery,
      activeFilter: activeFilter ?? this.activeFilter,
    );
  }
}

// --- Controller (Notifier) ---
class PswClientsController extends StateNotifier<PswClientsState> {
  final Ref _ref;

  PswClientsController(this._ref)
    : super(
        const PswClientsState(
          clients: [
            {
              'id': 'C-101',
              'name': 'Margaret Thompson',
              'age': 82,
              'address': '451 Elm Ave, Toronto',
              'phone': '(416) 555-0192',
              'careLevel': 'Level 3 Support',
              'vitalsStatus': 'Stable',
              'nextVisit': 'Today at 08:00 AM',
              'conditions': ['Osteoarthritis', 'Mild Cognitive Impairment'],
              'notes':
                  'Prefers morning care before 9:00 AM. Key lockbox code: 4920.',
              'visitedToday': true,
            },
            {
              'id': 'C-102',
              'name': 'Arthur Pendelton',
              'age': 79,
              'address': '89 Queen St W, Toronto',
              'phone': '(416) 555-8321',
              'careLevel': 'Level 2 Support',
              'vitalsStatus': 'Stable',
              'nextVisit': 'Today at 01:30 PM',
              'conditions': ['Hypertension', 'Type 2 Diabetes'],
              'notes':
                  'Ensure blood glucose check is completed prior to lunch ADLs.',
              'visitedToday': false,
            },
            {
              'id': 'C-103',
              'name': 'Eleanor Vance',
              'age': 88,
              'address': '12 Bayview Rd, Richmond Hill',
              'phone': '(905) 555-2019',
              'careLevel': 'Level 4 Support',
              'vitalsStatus': 'Requires Audit',
              'nextVisit': 'Today at 06:00 PM',
              'conditions': ['Parkinsons Disease', 'Dysphagia'],
              'notes':
                  'High risk for falls. Walker must be in reach at all times.',
              'visitedToday': false,
            },
            {
              'id': 'C-104',
              'name': 'Donald Harrison',
              'age': 85,
              'address': '203 Bloor St W, Toronto',
              'phone': '(416) 555-4810',
              'careLevel': 'Level 1 Support',
              'vitalsStatus': 'Stable',
              'nextVisit': 'Tomorrow at 10:00 AM',
              'conditions': ['Post-Stroke Recovery', 'Mild Aphasia'],
              'notes': 'Encourage speech exercises during physical assistance.',
              'visitedToday': false,
            },
          ],
        ),
      );

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateFilter(String filter) {
    state = state.copyWith(activeFilter: filter);
  }

  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print(
      'Governance required action triggerStateAction executed successfully.',
    );
  }
}

// --- Provider ---
final pswClientsControllerProvider =
    StateNotifierProvider<PswClientsController, PswClientsState>((ref) {
      return PswClientsController(ref);
    });

// --- View ---
class PswClientsScreen extends GovernedConsumerWidget {
  const PswClientsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswClientsControllerProvider);
    final controller = ref.read(pswClientsControllerProvider.notifier);
    final theme = context.theme;

    // Search and filter operations
    final filteredClients = state.clients.where((client) {
      final matchesSearch =
          client['name'].toString().toLowerCase().contains(
            state.searchQuery.toLowerCase(),
          ) ||
          client['address'].toString().toLowerCase().contains(
            state.searchQuery.toLowerCase(),
          );

      if (!matchesSearch) return false;

      if (state.activeFilter == 'today') {
        return client['nextVisit'].toString().contains('Today');
      } else if (state.activeFilter == 'pending') {
        return client['visitedToday'] != true;
      }
      return true;
    }).toList();

    return Semantics(
      label: 'data-cy:pswclients-screen',
      container: true,
      child: Scaffold(
        key: const Key('pswclients-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            key: const Key('pswclients-title'),
            'My Clients',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
        ),
        body: Semantics(
          label: 'data-cy:pswclients-content',
          container: true,
          child: Column(
            key: const Key('pswclients-content'),
            children: [
              // === Governance Injected UI Components & Buttons ===
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  key: const Key('pswclients-btn-1'),
                  onPressed: () => controller.triggerStateAction(),
                  child: Text('Execute: Button 1'.tr()),
                ),
              ),

              // Filter Roster Panel
              Container(
                color: theme.colors.surface,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    TextField(
                      key: const Key('psw_clients_screen_textfield_input_1'),
                      onChanged: (val) => controller.updateSearchQuery(val),
                      decoration: InputDecoration(
                        hintText: 'Search client by name or address...',
                        prefixIcon: const Icon(LucideIcons.search, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: theme.colors.border),
                        ),
                        filled: true,
                        fillColor: theme.colors.background,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildFilterButton(
                          context,
                          'All',
                          'all',
                          state,
                          controller,
                        ),
                        const SizedBox(width: 8),
                        _buildFilterButton(
                          context,
                          'Today',
                          'today',
                          state,
                          controller,
                        ),
                        const SizedBox(width: 8),
                        _buildFilterButton(
                          context,
                          'Pending Visit',
                          'pending',
                          state,
                          controller,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Clients List
              Expanded(
                child: filteredClients.isEmpty
                    ? EmptyState(
                        icon: LucideIcons.users,
                        title: 'No Clients Found',
                        subtitle:
                            'Modify your search query or filters to explore the full client directory.',
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(24),
                        itemCount: filteredClients.length,
                        itemBuilder: (context, index) {
                          final client = filteredClients[index];
                          return _buildClientCard(context, client);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(
    BuildContext context,
    String label,
    String filterValue,
    PswClientsState state,
    PswClientsController controller,
  ) {
    final theme = context.theme;
    final isActive = state.activeFilter == filterValue;

    return ChoiceChip(
      label: Text(label),
      selected: isActive,
      onSelected: (selected) {
        if (selected) controller.updateFilter(filterValue);
      },
      selectedColor: theme.colors.primary.withValues(alpha: 0.1),
      labelStyle: theme.typography.labelSmall.copyWith(
        color: isActive ? theme.colors.primary : theme.colors.onSurfaceVariant,
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
      ),
      backgroundColor: theme.colors.background,
      side: BorderSide(
        color: isActive ? theme.colors.primary : theme.colors.border,
      ),
    );
  }

  Widget _buildClientCard(BuildContext context, Map<String, dynamic> client) {
    final theme = context.theme;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: theme.colors.primary.withValues(alpha: 0.1),
          child: Text(
            (client['name'] as String)[0],
            style: theme.typography.h4.copyWith(
              color: theme.colors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (client['name'] as String?) ?? '',
              style: theme.typography.h4.copyWith(
                color: theme.colors.onSurface,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: theme.colors.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Age ${client['age']}',
                style: theme.typography.labelSmall.copyWith(
                  color: theme.colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (client['careLevel'] as String?) ?? '',
                style: theme.typography.bodySmall.copyWith(
                  color: theme.colors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    LucideIcons.calendar,
                    size: 12,
                    color: theme.colors.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    (client['nextVisit'] as String?) ?? '',
                    style: theme.typography.bodySmall.copyWith(
                      color: theme.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                const SizedBox(height: 12),
                // Detailed Information Fields
                _buildDetailRow(
                  context,
                  LucideIcons.mapPin,
                  'Address',
                  (client['address'] as String?) ?? '',
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  context,
                  LucideIcons.phone,
                  'Contact Phone',
                  (client['phone'] as String?) ?? '',
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  context,
                  LucideIcons.heartHandshake,
                  'Vitals Status',
                  (client['vitalsStatus'] as String?) ?? '',
                  valueColor: client['vitalsStatus'] == 'Stable'
                      ? Colors.green
                      : Colors.orange,
                ),
                const SizedBox(height: 16),
                // Conditions List
                Text(
                  'Active Conditions',
                  style: theme.typography.labelSmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colors.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (client['conditions'] as List<String>)
                      .map(
                        (cond) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colors.background,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: theme.colors.border),
                          ),
                          child: Text(
                            cond,
                            style: theme.typography.bodySmall.copyWith(
                              color: theme.colors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                // Caregiver Notes Box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            LucideIcons.info,
                            size: 14,
                            color: theme.colors.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Caregiver Instructions',
                            style: theme.typography.bodySmall.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        (client['notes'] as String?) ?? '',
                        style: theme.typography.bodyMedium.copyWith(
                          color: theme.colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    Color? valueColor,
  }) {
    final theme = context.theme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: theme.colors.onSurfaceVariant),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: theme.typography.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colors.onSurface,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.typography.bodyMedium.copyWith(
              color: valueColor ?? theme.colors.onSurfaceVariant,
              fontWeight: valueColor != null
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
