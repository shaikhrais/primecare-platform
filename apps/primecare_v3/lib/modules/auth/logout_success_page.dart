import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primecare_ui/primecare_ui.dart';

class LogoutSuccessPageWidget extends StatefulWidget {
  const LogoutSuccessPageWidget({super.key});

  @override
  State<LogoutSuccessPageWidget> createState() => _LogoutSuccessPageWidgetState();
}

class _LogoutSuccessPageWidgetState extends State<LogoutSuccessPageWidget> {
  @override
  void initState() {
    super.initState();
    // Auto-redirect to login after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthSplitLayout(
      title: 'Session Terminated',
      subtitle: 'Your enterprise credentials have been securely wiped from this device.',
      imageUrl: 'https://images.unsplash.com/photo-1551076805-e1869033e561?q=80&w=2560&auto=format&fit=crop',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.shield_outlined, size: 64, color: Colors.blueAccent),
          ),
          const SizedBox(height: 32),
          Text(
            'Securely Signed Out',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 16),
          const Text(
            'We are redirecting you back to the Authentication Gateway...',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.5),
          ),
          const SizedBox(height: 48),
          OutlinedButton(
            onPressed: () => context.go('/login'),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white24),
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Return Now', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
