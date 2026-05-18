// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class PswPatientProfileScreen extends ConsumerWidget {
  const PswPatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My Clients', style: theme.typography.h2),
                SearchBarWidget(hintText: 'Search clients...'),
              ],
            ),
            SizedBox(height: theme.spacing.xl),
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: theme.spacing.lg,
              mainAxisSpacing: theme.spacing.lg,
              shrinkWrap: true,
              childAspectRatio: 0.85,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildClientCard(theme, name: 'Eleanor Vance', age: 82, condition: 'Alzheimer\'s (Early Stage)', riskLevel: 'Medium'),
                _buildClientCard(theme, name: 'Arthur Pendelton', age: 76, condition: 'Post-Op Recovery', riskLevel: 'High'),
                _buildClientCard(theme, name: 'Sophia Lin', age: 68, condition: 'Mobility Assistance', riskLevel: 'Low'),
                _buildClientCard(theme, name: 'James Miller', age: 88, condition: 'Palliative Care', riskLevel: 'High'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClientCard(PrimeThemeData theme, {
    required String name,
    required int age,
    required String condition,
    required String riskLevel,
  }) {
    Color riskColor;
    if (riskLevel == 'High') riskColor = theme.colors.error;
    else if (riskLevel == 'Medium') riskColor = theme.colors.warning;
    else riskColor = theme.colors.success;

    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: theme.colors.primary.withValues(alpha: 0.1),
            child: Text(
              name.substring(0, 1),
              style: theme.typography.h2.copyWith(color: theme.colors.primary),
            ),
          ),
          SizedBox(height: theme.spacing.md),
          Text(name, style: theme.typography.h4, textAlign: TextAlign.center),
          Text('$age years old', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface.withValues(alpha: 0.6))),
          SizedBox(height: theme.spacing.md),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: riskColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$riskLevel Risk',
              style: theme.typography.labelMedium.copyWith(color: riskColor, fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          Divider(color: theme.colors.border.withValues(alpha: 0.5)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.activity, size: 16, color: theme.colors.onSurface.withValues(alpha: 0.5)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    condition,
                    style: theme.typography.labelMedium,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                side: BorderSide(color: theme.colors.primary.withValues(alpha: 0.5)),
              ),
              child: Text('View Profile', style: TextStyle(color: theme.colors.primary)),
            ),
          )
        ],
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  final String hintText;
  const SearchBarWidget({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(LucideIcons.search, color: theme.colors.onSurface.withValues(alpha: 0.5)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
    );
  }
}
