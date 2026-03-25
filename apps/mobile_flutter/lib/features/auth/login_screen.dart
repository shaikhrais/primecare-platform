import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/api_client.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../../core/theme_provider.dart';
import '../../core/widgets/language_toggle_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMsg;

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMsg = null;
    });

    try {
      await apiClient.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (mounted) {
        final prefs = await SharedPreferences.getInstance();
        final role = prefs.getString('user_role') ?? 'psw';
        switch (role) {
          case 'mt':
            context.go('/mt/home');
            break;
          case 'gm':
          case 'general_manager':
            context.go('/gm/home');
            break;
          case 'rn':
            context.go('/rn/home');
            break;
          case 'coordinator':
            context.go('/coordinator/home');
            break;
          case 'scrum_master':
          case 'developer':
            context.go('/scrum-master/home');
            break;
          case 'manager':
            context.go('/manager/home');
            break;
          case 'admin':
          case 'super_admin':
            context.go('/admin/home');
            break;
          case 'client':
            context.go('/client/home');
            break;
          default:
            context.go('/psw/home');
        }
      }
    } catch (e) {
      setState(() {
        _errorMsg = e.toString();
      });
    } finally {
      if (mounted)
        setState(() {
          _isLoading = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;

    return PrimeCareScaffold(
      appBar: PrimeCareNavBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        title: const SizedBox.shrink(),
        actions: [
          const LanguageToggleButton(),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Toggle Theme',
            icon: PrimeCareIcon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 900;

          Widget loginForm = Container(
            width: isDesktop ? 400 : double.infinity,
            decoration: isDesktop
                ? null
                : BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 32,
                        spreadRadius: -8,
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
            child: PrimeCareCard(
              padding: EdgeInsets.all(isDesktop ? 48.0 : 32.0),
              child: PrimeCareColumn(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PrimeCareText(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  PrimeCareText(
                    'Access the PrimeCare Mobile Platform',
                    style: TextStyle(
                      fontSize: 14,
                      color: PrimeCareColors.slate500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),
                  if (_errorMsg != null)
                    PrimeCareCard(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(bottom: 16),
                      child: PrimeCareText(
                        _errorMsg!,
                        style: TextStyle(
                          color: PrimeCareColors.rose,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  TextField(
                    controller: _emailController,
                    style: TextStyle(
                      color:
                          Theme.of(context).textTheme.bodyMedium?.color ??
                          PrimeCareColors.radarDark,
                    ),
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.emailAddress,
                      labelStyle: TextStyle(color: PrimeCareColors.slate500),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    style: TextStyle(
                      color:
                          Theme.of(context).textTheme.bodyMedium?.color ??
                          PrimeCareColors.radarDark,
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _isLoading ? null : _handleLogin(),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.password,
                      labelStyle: TextStyle(color: PrimeCareColors.slate500),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 24),
                  PrimeCareButton(
                    type: PrimeCareButtonType.primary,
                    onPressed: _isLoading ? null : _handleLogin,
                    child: _isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : PrimeCareText(
                            'Authenticate Security Token',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  SizedBox(height: 16),
                  PrimeCareButton(
                    type: PrimeCareButtonType.text,
                    onPressed: () => context.push('/forgot-password'),
                    child: PrimeCareText(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFF0EA5E9),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );

          if (isDesktop) {
            return Center(
              child: Container(
                width: 1000,
                margin: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.40),
                      blurRadius: 48,
                      offset: const Offset(0, 24),
                    ),
                  ],
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(24),
                            ),
                          ),
                          padding: EdgeInsets.all(48),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.security_rounded,
                                size: 72,
                                color: Colors.white,
                              ),
                              SizedBox(height: 32),
                              Text(
                                'Enterprise Grade\nSecurity Matrix',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  height: 1.1,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Your authentication session is protected by military-grade AES-256 encryption. The PrimeCare matrix validates every login attempt against zero-trust architectural boundaries natively.',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: 48),
                              Row(
                                children: [
                                  Icon(
                                    Icons.verified_user_rounded,
                                    color: PrimeCareColors.emerald,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'HIPAA & SOC2 Compliant',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 48.0),
                            child: loginForm,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return PrimeCareCenter(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.0),
              child: loginForm,
            ),
          );
        },
      ),
    );
  }
}
