import 'package:flutter/material.dart';
import 'responsive_layout_manager.dart';

class DesktopPaneWrapper extends StatelessWidget {
  final Widget child;
  
  const DesktopPaneWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutManager(
      mobile: child,
      desktop: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 24, offset: Offset(0, 8))],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: child,
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withAlpha(10),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.shield_rounded, color: Theme.of(context).colorScheme.primary, size: 40),
                        const SizedBox(height: 24),
                        Text('Enterprise Operation Protocol', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 24)),
                        const SizedBox(height: 16),
                        Text('Ensure all patient records, communications, and clinical inputs are verified precisely before physical transmission. All payload data is instantly encrypted locally utilizing local AES-256 blocks before transmitting securely into the PrimeCare Cloudflare node matrix.', 
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6, color: Theme.of(context).colorScheme.primary.withAlpha(200))),
                        const SizedBox(height: 32),
                        const Divider(),
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            Icon(Icons.verified_user, color: Theme.of(context).colorScheme.secondary, size: 24),
                            const SizedBox(width: 16),
                            const Text('End-To-End Encrypted Link', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
