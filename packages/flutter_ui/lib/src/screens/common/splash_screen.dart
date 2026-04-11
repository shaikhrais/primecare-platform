import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_core/flutter_core.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();

    // Emulate initial asset loading and backend hydration checks
    Timer(const Duration(milliseconds: 2500), _checkAuthAndNavigate);
  }

  void _checkAuthAndNavigate() {
    if (!mounted) return;

    final authState = ref.read(authProvider);
    if (authState.isAuthenticated) {
      final role = authState.role ?? '';
      context.go(AuthNotifier.getDashboardRouteForRole(role));
    } else {
      context.go(CommonRoutes.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Slate 900
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Brand Identity Icon
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF38BDF8).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF38BDF8).withValues(alpha: 0.2),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF38BDF8,
                            ).withValues(alpha: 0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        LucideIcons.shieldCheck,
                        size: 72,
                        color: Color(0xFF38BDF8),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Typography
                    Text(
                      'PRIMECARE',
                      style: GoogleFonts.outfit(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 8.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'auth.zero_trust_platform'.tr(),
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        letterSpacing: 4.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 64),
                    // Loading Indication
                    SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        backgroundColor: const Color(0xFF1E293B),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF38BDF8),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'auth.hydrating_registries'.tr(),
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
