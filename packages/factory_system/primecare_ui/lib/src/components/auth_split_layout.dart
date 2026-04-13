import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthSplitLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final String subtitle;
  final String imageUrl;

  const AuthSplitLayout({
    super.key,
    required this.child,
    required this.title,
    required this.subtitle,
    this.imageUrl =
        'https://images.unsplash.com/photo-1551076805-e1869033e561?q=80&w=2560&auto=format&fit=crop',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Slate 900
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
                      color: Colors.black,
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          const Color(0xFF0F172A).withValues(alpha: 0.6),
                          BlendMode.srcOver,
                        ),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(64),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            const Color(0xFF0F172A).withValues(alpha: 0.9),
                          ],
                        ),
                      ),
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.shield_rounded,
                            size: 48,
                            color: Colors.blueAccent,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            title,
                            style: GoogleFonts.outfit(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: -1,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            subtitle,
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color: Colors.blueGrey.shade200,
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
                        constraints: const BoxConstraints(maxWidth: 480),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 64,
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
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  const Color(0xFF0F172A).withValues(alpha: 0.85),
                  BlendMode.srcOver,
                ),
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 480),
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.shield_rounded,
                            size: 48,
                            color: Colors.blueAccent,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            subtitle,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.blueGrey.shade200,
                            ),
                          ),
                          const SizedBox(height: 48),
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
