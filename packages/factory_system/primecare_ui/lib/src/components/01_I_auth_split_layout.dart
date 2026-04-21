// Layer: 01_INFRASTRUCTURE
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primecare_core/00_B_flutter_core.dart';

class AuthSplitLayout extends ConsumerWidget {
  final Widget child;
  final String title;
  final String subtitle;
  final String imageUrl;
  final ImageProvider? backgroundImage;

  const AuthSplitLayout({
    super.key,
    required this.child,
    required this.title,
    required this.subtitle,
    this.imageUrl =
        'https://images.unsplash.com/photo-1551076805-e1869033e561?q=80&w=2560&auto=format&fit=crop',
    this.backgroundImage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = ref.watch(layoutProvider).scaleFactor;
    final ds = PrimeCareDesignSystem.of(context);
    return Scaffold(
      backgroundColor: ds.colors.surface,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 1024) {
            // Desktop Split Layout
            return Row(
              children: [
                // Left Panel (Image)
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: PrimeCareColors.black,
                      image: DecorationImage(
                        image: backgroundImage ?? NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          ds.colors.surface.withValues(alpha: 0.6),
                          BlendMode.srcOver,
                        ),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(
                        PrimeCareSpacing.scaled(64, scale),
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            ds.colors.surface.withValues(alpha: 0.9),
                          ],
                        ),
                      ),
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.shield_rounded,
                            size: PrimeCareSpacing.scaled(48, scale),
                            color: ds.colors.primary,
                          ),
                          SizedBox(height: PrimeCareSpacing.scaled(24, scale)),
                          Text(
                            title,
                            style: GoogleFonts.outfit(
                              fontSize: PrimeCareSpacing.scaled(48, scale),
                              fontWeight: FontWeight.bold,
                              color: PrimeCareColors.white,
                              letterSpacing: -1,
                            ),
                          ),
                          SizedBox(height: PrimeCareSpacing.scaled(16, scale)),
                          Text(
                            subtitle,
                            style: GoogleFonts.inter(
                              fontSize: PrimeCareSpacing.scaled(18, scale),
                              color: ds.colors.textSecondary,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Right Panel (Auth Form)
                Expanded(
                  flex: 5,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: PrimeCareSpacing.scaled(480, scale),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: PrimeCareSpacing.scaled(48, scale),
                          vertical: PrimeCareSpacing.scaled(64, scale),
                        ),
                        child: child,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          // Mobile / Tablet Layout (Glassmorphism Overlay)
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: backgroundImage ?? NetworkImage(imageUrl),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  const Color(0xFF0F172A).withValues(alpha: 0.85),
                  BlendMode.srcOver,
                ),
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(PrimeCareSpacing.scaled(24, scale)),
                child: ClipRRect(
                  borderRadius: PrimeCareRadii.scaled(scale),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        maxWidth: PrimeCareSpacing.scaled(480, scale),
                      ),
                      padding: EdgeInsets.all(
                        PrimeCareSpacing.scaled(40, scale),
                      ),
                      decoration: BoxDecoration(
                        color: PrimeCareColors.white.withValues(alpha: 0.08),
                        borderRadius: PrimeCareRadii.scaled(scale),
                        border: Border.all(
                          color: PrimeCareColors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shield_rounded,
                            size: PrimeCareSpacing.scaled(48, scale),
                            color: ds.colors.primary,
                          ),
                          SizedBox(height: PrimeCareSpacing.scaled(24, scale)),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: PrimeCareSpacing.scaled(32, scale),
                              fontWeight: FontWeight.bold,
                              color: PrimeCareColors.white,
                            ),
                          ),
                          SizedBox(height: PrimeCareSpacing.scaled(8, scale)),
                          Text(
                            subtitle,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: PrimeCareSpacing.scaled(14, scale),
                              color: ds.colors.textSecondary,
                            ),
                          ),
                          SizedBox(height: PrimeCareSpacing.scaled(48, scale)),
                          child,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Using dynamicPageProvider and ViewModel pattern for data binding.
