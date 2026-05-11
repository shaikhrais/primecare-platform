import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter/foundation.dart';
import '../../core/config/env_config.dart';
import 'dart:ui';
import 'login_controller.dart';

/// An enterprise-grade, governed login screen.
/// Follows 'No-Logic UI' policy by delegating all authentication logic to [LoginController].
class LoginView extends GovernedScreen {
  const LoginView({super.key});

  @override
  String get featureId => 'auth.login';

  @override
  String get requiredRole => 'Public';

  @override
  Widget buildGovernedView(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(loginControllerProvider);
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: theme.colors.background,
      body: Stack(
        children: [
          Row(
            children: [
              // 1. Half Billboard (Left Side)
              if (isDesktop) const Expanded(flex: 1, child: _LoginBillboard()),

              // 2. Login Form (Right Side)
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    const _BackgroundVisuals(),
                    Center(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: theme.spacing.xl),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 440),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (!isDesktop) const _LoginBranding(),
                              if (!isDesktop) const SizedBox(height: 48),
                              _LoginCard(state: state),
                              const SizedBox(height: 48),
                              const _LoginFooter(),
                              const SizedBox(height: 24),
                              const _RoleSimulationCenter(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BackgroundVisuals extends StatelessWidget {
  const _BackgroundVisuals();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.0, 0.4, 1.0],
                colors: [
                  theme.colors.primary.withValues(alpha: 0.08),
                  theme.colors.background,
                  theme.colors.secondary.withValues(alpha: 0.05),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -150,
          right: -100,
          child: _BlurredBlob(
            color: theme.colors.primary.withValues(alpha: 0.12),
            size: 500,
          ),
        ),
        Positioned(
          bottom: -100,
          left: -50,
          child: _BlurredBlob(
            color: theme.colors.secondary.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
      ],
    );
  }
}

class _LoginBranding extends StatelessWidget {
  const _LoginBranding();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      children: [
        Hero(
          tag: 'app_logo',
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.security_update_good_rounded,
              size: 48,
              color: theme.colors.primary,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'PRIMECARE',
          style: theme.typography.h1.copyWith(
            letterSpacing: 6,
            fontWeight: FontWeight.w900,
            fontSize: 28,
          ),
        ),
        Text(
          'GOVERNANCE GATEWAY',
          style: theme.typography.labelMedium.copyWith(
            letterSpacing: 3,
            color: theme.colors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _LoginCard extends ConsumerWidget {
  final LoginState state;
  const _LoginCard({required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final controller = ref.read(loginControllerProvider.notifier);

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: EdgeInsets.all(theme.spacing.xxl),
          decoration: BoxDecoration(
            color: theme.colors.surface.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: theme.colors.border.withValues(alpha: 0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Authorized Access',
                style: theme.typography.h3,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your secure credentials to continue',
                style: theme.typography.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _InputField(
                label: 'IDENTIFIER',
                placeholder: 'admin@primecare.com',
                icon: Icons.person_outline_rounded,
                initialValue: state.email,
                onChanged: controller.onEmailChanged,
              ),
              const SizedBox(height: 20),
              _InputField(
                label: 'SECURITY TOKEN',
                placeholder: '••••••••',
                icon: Icons.key_outlined,
                obscureText: true,
                initialValue: state.password,
                onChanged: controller.onPasswordChanged,
              ),
              if (state.errorMessage != null) ...[
                const SizedBox(height: 20),
                _ErrorDisplay(message: state.errorMessage!),
              ],
              const SizedBox(height: 32),
              if (state.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                _ActionButtons(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final String placeholder;
  final IconData icon;
  final bool obscureText;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const _InputField({
    required this.label,
    required this.placeholder,
    required this.icon,
    this.obscureText = false,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: theme.typography.labelMedium.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              color: theme.colors.onSurfaceVariant,
            ),
          ),
        ),
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          obscureText: obscureText,
          style: theme.typography.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            prefixIcon: Icon(
              icon,
              size: 20,
              color: theme.colors.primary.withValues(alpha: 0.6),
            ),
            filled: true,
            fillColor: theme.colors.surfaceContainerHighest.withValues(
              alpha: 0.3,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: theme.colors.primary, width: 2),
            ),
            hintStyle: theme.typography.labelMedium.copyWith(
              color: theme.colors.onSurfaceVariant.withValues(alpha: 0.4),
            ),
          ),
        ),
      ],
    );
  }
}

class _ErrorDisplay extends StatelessWidget {
  final String message;
  const _ErrorDisplay({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colors.error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colors.error.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 16,
            color: theme.colors.error,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: theme.typography.labelMedium.copyWith(
                color: theme.colors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final LoginController controller;
  const _ActionButtons({required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      children: [
        ElevatedButton(
          onPressed: controller.login,
          style:
              ElevatedButton.styleFrom(
                backgroundColor: theme.colors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ).copyWith(
                overlayColor: WidgetStateProperty.all(
                  Colors.white.withValues(alpha: 0.1),
                ),
              ),
          child: const Center(
            child: Text(
              'INITIATE SESSION',
              style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5),
            ),
          ),
        ),
        if (kDebugMode ||
            EnvConfig.environment == Environment.demo ||
            EnvConfig.environment == Environment.dev) ...[
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: controller.loginWithDemo,
            style: OutlinedButton.styleFrom(
              foregroundColor: theme.colors.primary,
              side: BorderSide(
                color: theme.colors.primary.withValues(alpha: 0.5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Center(
              child: Text(
                'ACCESS DEMO MODE',
                style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 1),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _LoginFooter extends StatelessWidget {
  const _LoginFooter();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Text(
      '© 2026 PRIMECARE PLATFORM · SECURITY LAYER 4',
      style: theme.typography.labelMedium.copyWith(
        color: theme.colors.onSurfaceVariant.withValues(alpha: 0.6),
        letterSpacing: 1,
      ),
    );
  }
}

class _LoginBillboard extends StatelessWidget {
  const _LoginBillboard();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Stack(
        children: [
          // 1. Premium Security Image
          Positioned.fill(
            child: Image.network(
              'security_billboard.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [theme.colors.primary, theme.colors.secondary],
                  ),
                ),
              ),
            ),
          ),
          
          // 2. Glassmorphism & Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
          ),

          // 3. Animated Mesh Gradient (Subtle)
          const Positioned.fill(child: _AnimatedBillboardMesh()),

          // 4. Content
          Padding(
            padding: EdgeInsets.all(theme.spacing.xxxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  children: [
                    _BillboardBadge(),
                    SizedBox(width: 12),
                    _SecurityVerifiedBadge(),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  'PRIMECARE',
                  style: theme.typography.h1.copyWith(
                    color: Colors.white,
                    fontSize: 84,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2,
                    height: 1,
                  ),
                ),
                Text(
                  'PLATFORM',
                  style: theme.typography.h2.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 32,
                    letterSpacing: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 64),
                const _RollingSlogans(),
                const Spacer(),
                const _BillboardFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BillboardBadge extends StatelessWidget {
  const _BillboardBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.verified_user_rounded, color: Colors.white, size: 16),
          const SizedBox(width: 8),
          Text(
            'SOC2 COMPLIANT · ISO 27001',
            style: context.theme.typography.labelMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _SecurityVerifiedBadge extends StatelessWidget {
  const _SecurityVerifiedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.shield, color: Colors.greenAccent, size: 14),
          const SizedBox(width: 8),
          Text(
            'GOVERNED & SECURE',
            style: context.theme.typography.labelSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _RollingSlogans extends StatefulWidget {
  const _RollingSlogans();

  @override
  State<_RollingSlogans> createState() => _RollingSlogansState();
}

class _RollingSlogansState extends State<_RollingSlogans>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int _currentIndex = 0;

  final List<String> _slogans = [
    'HARDENED GOVERNANCE INFRASTRUCTURE',
    'ZERO-ERROR AUDIT ENFORCEMENT',
    'PRECISION CARE. ABSOLUTE SECURITY.',
    'ARCHITECTURAL INTEGRITY VERIFIED',
    'ZERO-TRUST SESSION MANAGEMENT',
    'REAL-TIME COMPLIANCE MONITORING',
    'ENTERPRISE SECURITY LAYER 4',
    'DECENTRALIZED IDENTITY PROTECTION',
    'CONTINUOUS PARITY VALIDATION',
    'GOVERNANCE REGISTRY HARDENED',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) {
          setState(() {
            _currentIndex = (_currentIndex + 1) % _slogans.length;
          });
          _controller.forward(from: 0);
        }
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'STABILITY & TRUST',
          style: context.theme.typography.labelMedium.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
            letterSpacing: 4,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 64,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.2),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: Text(
              _slogans[_currentIndex],
              key: ValueKey(_currentIndex),
              style: context.theme.typography.h3.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 28,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BillboardFooter extends StatelessWidget {
  const _BillboardFooter();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SECURE DEPLOYMENT NODE: NA-EAST-1',
          style: context.theme.typography.labelSmall.copyWith(
            color: Colors.white.withValues(alpha: 0.5),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.greenAccent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'ALL SYSTEMS OPERATIONAL',
              style: context.theme.typography.labelSmall.copyWith(
                color: Colors.white.withValues(alpha: 0.7),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AnimatedBillboardMesh extends StatelessWidget {
  const _AnimatedBillboardMesh();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -100,
          child: _BlurredBlob(
            color: Colors.white.withValues(alpha: 0.1),
            size: 600,
          ),
        ),
        Positioned(
          bottom: -200,
          left: -100,
          child: _BlurredBlob(
            color: Colors.black.withValues(alpha: 0.2),
            size: 800,
          ),
        ),
      ],
    );
  }
}

class _RoleSimulationCenter extends ConsumerWidget {
  const _RoleSimulationCenter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final controller = ref.read(loginControllerProvider.notifier);

    // Only show in non-production environments
    if (kReleaseMode && EnvConfig.environment == Environment.prod) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'ROLE SIMULATION CENTER',
                style: theme.typography.labelSmall.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  color: theme.colors.onSurfaceVariant.withValues(alpha: 0.5),
                ),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            _SimulationChip(
              label: 'CEO',
              onTap: () => controller.simulateLogin('CEO'),
              isHighPrivilege: true,
            ),
            _SimulationChip(
              label: 'Corporate',
              onTap: () => controller.simulateLogin('Corporate Admin'),
              isHighPrivilege: true,
            ),
            _SimulationChip(
              label: 'Clinical',
              onTap: () => controller.simulateLogin('Clinical Director'),
            ),
            _SimulationChip(
              label: 'PSW',
              onTap: () => controller.simulateLogin('PSW'),
            ),
            _SimulationChip(
              label: 'Audit',
              onTap: () => controller.simulateLogin('Platform Auditor'),
            ),
            _SimulationChip(
              label: 'View All (55)',
              onTap: () => _showAllRoles(context, controller),
              isGhost: true,
            ),
          ],
        ),
      ],
    );
  }

  void _showAllRoles(BuildContext context, LoginController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => _AllRolesSheet(
            onSelect: (role) {
              Navigator.pop(context);
              controller.simulateLogin(role);
            },
          ),
    );
  }
}

class _SimulationChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isHighPrivilege;
  final bool isGhost;

  const _SimulationChip({
    required this.label,
    required this.onTap,
    this.isHighPrivilege = false,
    this.isGhost = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color:
              isGhost
                  ? Colors.transparent
                  : (isHighPrivilege
                      ? theme.colors.primary.withValues(alpha: 0.1)
                      : theme.colors.surfaceContainerHighest.withValues(
                        alpha: 0.5,
                      )),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color:
                isGhost
                    ? theme.colors.border
                    : (isHighPrivilege
                        ? theme.colors.primary.withValues(alpha: 0.3)
                        : Colors.transparent),
          ),
        ),
        child: Text(
          label,
          style: theme.typography.labelSmall.copyWith(
            fontWeight: FontWeight.bold,
            color: isHighPrivilege ? theme.colors.primary : null,
          ),
        ),
      ),
    );
  }
}

class _AllRolesSheet extends StatefulWidget {
  final ValueChanged<String> onSelect;
  const _AllRolesSheet({required this.onSelect});

  @override
  State<_AllRolesSheet> createState() => _AllRolesSheetState();
}

class _AllRolesSheetState extends State<_AllRolesSheet> {
  String _search = '';

  final List<String> _roles = [
    'CEO',
    'COO',
    'CFO',
    'CIO',
    'Corporate Admin',
    'Regional Director',
    'Clinical Director',
    'Medical Director',
    'Director of Nursing',
    'Finance Director',
    'HR Director',
    'Compliance Officer',
    'Platform Auditor',
    'Facility Manager',
    'Unit Manager',
    'Registered Nurse',
    'LPN/RPN',
    'PSW',
    'Physician',
    'Pharmacist',
    'Dietitian',
    'Occupational Therapist',
    'Physical Therapist',
    'Social Worker',
    'Recreation Manager',
    'Supply Chain Manager',
    'IT Administrator',
    'System Architect',
    'Data Scientist',
    'Security Engineer',
    'Support Specialist',
    'Maintenance Manager',
    'Quality Specialist',
    'Education Coordinator',
    'Admissions Director',
    'Marketing Manager',
    'Legal Counsel',
    'Risk Manager',
    'Vendor Coordinator',
    'Patient Advocate',
    'Volunteer Coordinator',
    'Staff Scheduler',
    'Payroll Specialist',
    'Billing Coordinator',
    'Records Manager',
    'Transcriptionist',
    'Laboratory Manager',
    'Imaging Specialist',
    'Kitchen Manager',
    'Housekeeping Lead',
    'Laundry Coordinator',
    'Concierge',
    'Security Officer',
    'Triage Nurse',
    'Emergency Coordinator',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final filtered =
        _roles
            .where((r) => r.toLowerCase().contains(_search.toLowerCase()))
            .toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: theme.colors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: theme.colors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Column(
              children: [
                Text(
                  'Architectural Parity Validation',
                  style: theme.typography.h3,
                ),
                const SizedBox(height: 4),
                Text(
                  'Select a role to verify its dashboard and navigation pruning',
                  style: theme.typography.labelMedium,
                ),
                const SizedBox(height: 24),
                TextField(
                  onChanged: (v) => setState(() => _search = v),
                  decoration: InputDecoration(
                    hintText: 'Search 55 platform roles...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: theme.colors.surfaceContainerHighest,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: theme.spacing.xl),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final role = filtered[index];
                return ListTile(
                  title: Text(
                    role,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.chevron_right, size: 16),
                  onTap: () => widget.onSelect(role),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: size / 4, sigmaY: size / 4),
        child: Container(color: Colors.transparent),
      ),
    );
  }
}
