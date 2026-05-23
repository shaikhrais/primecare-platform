// Governance - Category: service | Purpose: Core implementation file for the User Management platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class UserManagementState {
  final List<Map<String, dynamic>> users;
  final String searchQuery;
  final String activeRoleFilter;
  final bool isCreatingUser;
  final bool isMutatingState;

  const UserManagementState({
    required this.users,
    required this.searchQuery,
    required this.activeRoleFilter,
    required this.isCreatingUser,
    required this.isMutatingState,
  });

  UserManagementState copyWith({
    List<Map<String, dynamic>>? users,
    String? searchQuery,
    String? activeRoleFilter,
    bool? isCreatingUser,
    bool? isMutatingState,
  }) {
    return UserManagementState(
      users: users ?? this.users,
      searchQuery: searchQuery ?? this.searchQuery,
      activeRoleFilter: activeRoleFilter ?? this.activeRoleFilter,
      isCreatingUser: isCreatingUser ?? this.isCreatingUser,
      isMutatingState: isMutatingState ?? this.isMutatingState,
    );
  }
}

// --- Controller ---
class UserManagementController extends StateNotifier<UserManagementState> {
  final Ref _ref;

  UserManagementController(this._ref)
      : super(
          const UserManagementState(
            users: [
              {
                'id': 'usr-001',
                'name': 'Sarah Jenkins',
                'role': 'PSW',
                'email': 's.jenkins@primecare.com',
                'status': 'Active',
                'office': 'Toronto Downtown',
                'joined': '2025-03-12',
              },
              {
                'id': 'usr-002',
                'name': 'David Miller',
                'role': 'RPN',
                'email': 'd.miller@primecare.com',
                'status': 'Active',
                'office': 'Toronto Downtown',
                'joined': '2025-05-01',
              },
              {
                'id': 'usr-003',
                'name': 'Margaret Thompson',
                'role': 'Client',
                'email': 'm.thompson@gmail.com',
                'status': 'Active',
                'office': 'Toronto Downtown',
                'joined': '2025-02-15',
              },
              {
                'id': 'usr-004',
                'name': 'Cynthia Vance',
                'role': 'Finance Director',
                'email': 'c.vance@primecare.com',
                'status': 'Locked',
                'office': 'Corporate Headquarters',
                'joined': '2024-11-20',
              },
              {
                'id': 'usr-005',
                'name': 'Marcus Aurelius',
                'role': 'COO',
                'email': 'm.aurelius@primecare.com',
                'status': 'Active',
                'office': 'Corporate Headquarters',
                'joined': '2024-01-10',
              },
            ],
            searchQuery: '',
            activeRoleFilter: 'all',
            isCreatingUser: false,
            isMutatingState: false,
          ),
        );

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateRoleFilter(String filter) {
    state = state.copyWith(activeRoleFilter: filter);
  }

  void toggleUserStatus(String userId) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/user_management',
            eventType: 'user_account_status_toggled',
            metadata: {'userId': userId},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 300), () {
      final updated = state.users.map((u) {
        if (u['id'] == userId) {
          final nextStatus = u['status'] == 'Active' ? 'Locked' : 'Active';
          return {...u, 'status': nextStatus};
        }
        return u;
      }).toList();

      state = state.copyWith(
        users: updated,
        isMutatingState: false,
      );
    });
  }

  void createUser({
    required String name,
    required String role,
    required String email,
    required String office,
  }) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/user_management',
            eventType: 'user_account_created',
            metadata: {
              'name': name,
              'role': role,
              'email': email,
              'office': office,
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 400), () {
      final newUser = {
        'id': 'usr-${DateTime.now().millisecondsSinceEpoch}',
        'name': name,
        'role': role,
        'email': email,
        'status': 'Active',
        'office': office,
        'joined': DateTime.now().toString().substring(0, 10),
      };

      state = state.copyWith(
        users: [newUser, ...state.users],
        isCreatingUser: false,
        isMutatingState: false,
      );
    });
  }

  void toggleCreateDrawer(bool open) {
    state = state.copyWith(isCreatingUser: open);
  }
}

// --- Provider ---
final userManagementControllerProvider =
    StateNotifierProvider<UserManagementController, UserManagementState>((ref) {
  return UserManagementController(ref);
});

// --- View ---
class UserManagement extends GovernedConsumerWidget {
  const UserManagement({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userManagementControllerProvider);
    final controller = ref.read(userManagementControllerProvider.notifier);
    final theme = context.theme;

    // Filtered User list
    final filteredUsers = state.users.where((u) {
      final matchesSearch = (u['name'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (u['email'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (u['office'] as String).toLowerCase().contains(state.searchQuery.toLowerCase());
      final matchesFilter = state.activeRoleFilter == 'all' ||
          (u['role'] as String).toLowerCase() == state.activeRoleFilter.toLowerCase();
      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.users, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Enterprise User Management Directory',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Row(
            children: [
              // Main Directory Area
              Expanded(
                flex: 7,
                child: Padding(
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
                                'Active Account Directory',
                                style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Manage platform users, update authorization roles, and toggle access keys.',
                                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                            ],
                          ),
                          ElevatedButton.icon(
                            onPressed: () => controller.toggleCreateDrawer(true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colors.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(theme.radiusMd),
                              ),
                            ),
                            icon: const Icon(LucideIcons.userPlus, size: 18),
                            label: const Text('Add New User'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Search and filters
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colors.surface,
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                          border: Border.all(color: theme.colors.border),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search by name, email, or office...',
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
                            // Filter buttons
                            Wrap(
                              spacing: 8,
                              children: [
                                _FilterButton(
                                  label: 'All Roles',
                                  value: 'all',
                                  activeValue: state.activeRoleFilter,
                                  onTap: controller.updateRoleFilter,
                                ),
                                _FilterButton(
                                  label: 'PSW',
                                  value: 'psw',
                                  activeValue: state.activeRoleFilter,
                                  onTap: controller.updateRoleFilter,
                                ),
                                _FilterButton(
                                  label: 'RN/RPN',
                                  value: 'rpn',
                                  activeValue: state.activeRoleFilter,
                                  onTap: controller.updateRoleFilter,
                                ),
                                _FilterButton(
                                  label: 'Client',
                                  value: 'client',
                                  activeValue: state.activeRoleFilter,
                                  onTap: controller.updateRoleFilter,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Directory list
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredUsers.length,
                          itemBuilder: (context, index) {
                            final user = filteredUsers[index];
                            final isActive = user['status'] == 'Active';

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
                                    backgroundColor: theme.colors.primary.withValues(alpha: 0.1),
                                    child: Icon(
                                      user['role'] == 'Client'
                                          ? LucideIcons.smile
                                          : LucideIcons.briefcase,
                                      color: theme.colors.primary,
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
                                              (user['name'] as String),
                                              style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: theme.colors.background,
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: theme.colors.border),
                                              ),
                                              child: Text(
                                                (user['role'] as String),
                                                style: theme.typography.bodyMedium.copyWith(
                                                  color: theme.colors.primary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${user['email']} • Office: ${user['office']}',
                                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Joined Date
                                  Text(
                                    'Joined: ${user['joined']}',
                                    style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                  ),
                                  const SizedBox(width: 24),
                                  // Lock Status Switcher
                                  GestureDetector(
                                    onTap: () => controller.toggleUserStatus((user['id'] as String)),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: isActive
                                            ? Colors.green.withValues(alpha: 0.1)
                                            : Colors.red.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: isActive ? Colors.green : Colors.red,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            isActive ? LucideIcons.unlock : LucideIcons.lock,
                                            size: 14,
                                            color: isActive ? Colors.green : Colors.red,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            (user['status'] as String),
                                            style: theme.typography.bodyMedium.copyWith(
                                              color: isActive ? Colors.green : Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
              ),
            ],
          ),

          // User Registration Form Drawer Overlay
          if (state.isCreatingUser)
            _CreateUserDrawer(
              onClose: () => controller.toggleCreateDrawer(false),
              onSubmit: (name, role, email, office) {
                controller.createUser(
                  name: name,
                  role: role,
                  email: email,
                  office: office,
                );
              },
            ),

          if (state.isMutatingState)
            Container(
              color: Colors.black.withValues(alpha: 0.1),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final String value;
  final String activeValue;
  final ValueChanged<String> onTap;

  const _FilterButton({
    required this.label,
    required this.value,
    required this.activeValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isActive = value == activeValue;

    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? theme.colors.primary : theme.colors.background,
          borderRadius: BorderRadius.circular(theme.radiusMd),
          border: Border.all(color: isActive ? theme.colors.primary : theme.colors.border),
        ),
        child: Text(
          label,
          style: theme.typography.bodyMedium.copyWith(
            color: isActive ? Colors.white : theme.colors.onSurface,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _CreateUserDrawer extends StatefulWidget {
  final VoidCallback onClose;
  final void Function(String name, String role, String email, String office) onSubmit;

  const _CreateUserDrawer({
    required this.onClose,
    required this.onSubmit,
  });

  @override
  State<_CreateUserDrawer> createState() => _CreateUserDrawerState();
}

class _CreateUserDrawerState extends State<_CreateUserDrawer> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _officeController = TextEditingController();
  String _selectedRole = 'PSW';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _officeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Stack(
      children: [
        // Backdrop overlay
        GestureDetector(
          onTap: widget.onClose,
          child: Container(color: Colors.black.withValues(alpha: 0.4)),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 450,
            height: double.infinity,
            color: theme.colors.surface,
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Create Platform Account',
                      style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                    ),
                    IconButton(
                      icon: const Icon(LucideIcons.x),
                      onPressed: widget.onClose,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Form Fields
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(theme.radiusMd),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(theme.radiusMd),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _officeController,
                  decoration: InputDecoration(
                    labelText: 'Assigned Office Branch',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(theme.radiusMd),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedRole,
                  decoration: InputDecoration(
                    labelText: 'Platform Authorization Role',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(theme.radiusMd),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'PSW', child: Text('PSW Caregiver')),
                    DropdownMenuItem(value: 'RPN', child: Text('RPN Nurse')),
                    DropdownMenuItem(value: 'Client', child: Text('Client Account')),
                    DropdownMenuItem(value: 'Finance Director', child: Text('Finance Director')),
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _selectedRole = val;
                      });
                    }
                  },
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: widget.onClose,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(theme.radiusMd),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_nameController.text.isNotEmpty &&
                              _emailController.text.isNotEmpty &&
                              _officeController.text.isNotEmpty) {
                            widget.onSubmit(
                              _nameController.text,
                              _selectedRole,
                              _emailController.text,
                              _officeController.text,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(theme.radiusMd),
                          ),
                        ),
                        child: const Text('Create User'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
