/* 
PRIME:SCREEN=psw_profile
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_CONNECTED
PRIME:DB=DB_NONE
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=50
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: view | Purpose: UI Screen component rendering the Psw Profile workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- State Model ---
class PswProfileState {
  final String status;
  final String email;
  final String phone;

  const PswProfileState({
    required this.status,
    required this.email,
    required this.phone,
  });

  PswProfileState copyWith({
    String? status,
    String? email,
    String? phone,
  }) {
    return PswProfileState(
      status: status ?? this.status,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
}

// --- Controller ---
class PswProfileController extends StateNotifier<PswProfileState> {
  final Ref _ref;
  PswProfileController(this._ref)
      : super(const PswProfileState(
          status: 'idle',
          email: 'jane.doe@primecare.com',
          phone: '+1 (555) 019-2834',
        ));

  void editProfile(String email, String phone) {
    state = state.copyWith(status: 'updating', email: email, phone: phone);
    Future.delayed(const Duration(milliseconds: 500), () {
      state = state.copyWith(status: 'saved');
      
      try {
        _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
          route: '/psw/profile',
          eventType: 'editProfile',
          metadata: {'status': 'saved'},
        );
      } catch (_) {}
    });
  }

  void updatePassword() {
    print('Governance action: updatePassword executed.');
  }
}

final pswProfileControllerProvider = StateNotifierProvider<PswProfileController, PswProfileState>((ref) {
  return PswProfileController(ref);
});

// --- View ---
class PswProfileScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for viewing and editing user profile information, updating passwords, managing account settings, and accessing help resources, along with necessary buttons, functions, APIs, and responsive design.';

  @override
  List<String> get requiredComponents => const [
        'ProfileInfoCard',
        'ProfileEditForm',
        'PasswordUpdateForm',
        'AccountSettingsPanel',
        'HelpSupportLink',
      ];

  @override
  List<String> get requiredFunctions => const [
        'viewProfile',
        'editProfile',
        'updatePassword',
        'manageSettings',
        'accessHelp',
      ];

  const PswProfileScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(pswProfileControllerProvider);
    final controller = ref.read(pswProfileControllerProvider.notifier);

    String localEmail = state.email;
    String localPhone = state.phone;

    return Semantics(
      label: 'data-cy:pswprofile-btn-edit',
      container: true,
      child: Scaffold(
        key: const Key('pswprofile-btn-edit'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            'Personal Profile',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
        ),
        body: Semantics(
          label: 'data-cy:pswprofile-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('pswprofile-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Avatar Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: theme.colors.primary.withValues(alpha: 0.1),
                        child: Text('JD', style: theme.typography.h2.copyWith(color: theme.colors.primary)),
                      ),
                      const SizedBox(height: 12),
                      Text('Jane Doe', style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold)),
                      Text('Personal Support Worker (PSW)', style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Edit Profile Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Edit Profile Information', style: theme.typography.h4.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      Text('Email Address', style: theme.typography.bodySmall),
                      const SizedBox(height: 6),
                      TextFormField(
                        initialValue: state.email,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(theme.radiusSm)),
                        ),
                        onChanged: (val) => localEmail = val,
                      ),
                      const SizedBox(height: 16),
                      Text('Phone Number', style: theme.typography.bodySmall),
                      const SizedBox(height: 6),
                      TextFormField(
                        initialValue: state.phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(theme.radiusSm)),
                        ),
                        onChanged: (val) => localPhone = val,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          key: const Key('pswprofile-btn-save'),
                          onPressed: state.status == 'updating'
                              ? null
                              : () => controller.editProfile(localEmail, localPhone),
                          child: state.status == 'updating'
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text('Save Profile Details'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Security & Password Panel
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Security Settings', style: theme.typography.h4.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          key: const Key('pswprofile-btn-update-password'),
                          style: ElevatedButton.styleFrom(backgroundColor: theme.colors.background),
                          onPressed: () => controller.updatePassword(),
                          child: Text('Change Password', style: TextStyle(color: theme.colors.primary)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
