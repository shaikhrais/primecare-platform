// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class PswVisitNotesScreen extends ConsumerWidget {
  const PswVisitNotesScreen({super.key});

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
                Text('Visit Notes', style: theme.typography.h2),
                ElevatedButton.icon(
                  label: Text('Add Note'),
                  icon: Icon(LucideIcons.plus),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: theme.spacing.xl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: PrimeCareCard(
                    padding: EdgeInsets.all(theme.spacing.xl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          maxLines: 8,
                          decoration: InputDecoration(
                            hintText: 'Enter clinical observations and notes...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: theme.colors.border),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: theme.colors.border.withValues(alpha: 0.5)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: theme.colors.primary),
                            ),
                            filled: true,
                            fillColor: theme.colors.background,
                          ),
                        ),
                        SizedBox(height: theme.spacing.lg),
                        Row(
                          children: [
                            Icon(LucideIcons.paperclip, color: theme.colors.onSurface.withValues(alpha: 0.5)),
                            SizedBox(width: 8),
                            Text('Attach File', style: theme.typography.bodyMedium.copyWith(color: theme.colors.primary)),
                            Spacer(),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: Text('Save Draft'),
                            ),
                            SizedBox(width: theme.spacing.md),
                            ElevatedButton(
                              child: Text('Submit Note'),
                              onPressed: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: theme.spacing.lg),
                Expanded(
                  flex: 1,
                  child: PrimeCareCard(
                    padding: EdgeInsets.all(theme.spacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Recent Notes', style: theme.typography.h4),
                        SizedBox(height: theme.spacing.md),
                        _buildRecentNoteTile(theme, date: 'May 16, 2026', client: 'Arthur P.', excerpt: 'Client experienced mild discomfort during transfer...'),
                        Divider(height: 24, color: theme.colors.border.withValues(alpha: 0.5)),
                        _buildRecentNoteTile(theme, date: 'May 15, 2026', client: 'Eleanor V.', excerpt: 'Morning routine completed without incident. Medication...'),
                        Divider(height: 24, color: theme.colors.border.withValues(alpha: 0.5)),
                        _buildRecentNoteTile(theme, date: 'May 14, 2026', client: 'Sophia L.', excerpt: 'Mobility exercises went well today. Client...'),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRecentNoteTile(PrimeThemeData theme, {required String date, required String client, required String excerpt}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(client, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
            Text(date, style: theme.typography.labelMedium),
          ],
        ),
        SizedBox(height: 4),
        Text(
          excerpt,
          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface.withValues(alpha: 0.6)),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
