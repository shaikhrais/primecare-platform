// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/primecare_ui.dart';

/// A shimmer loading state for the Intelligence Insight Panel.
class ShimmerIntelligencePanel extends StatelessWidget {
  const ShimmerIntelligencePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      children: List.generate(
        3,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: theme.spacing.md),
          child: PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const PrimeCareSkeleton(
                      width: 32,
                      height: 32,
                      borderRadius: 8,
                    ),
                    SizedBox(width: theme.spacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const PrimeCareSkeleton(width: 150, height: 16),
                          SizedBox(height: theme.spacing.xs),
                          const PrimeCareSkeleton(width: 100, height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: theme.spacing.md),
                const PrimeCareSkeleton(width: double.infinity, height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
