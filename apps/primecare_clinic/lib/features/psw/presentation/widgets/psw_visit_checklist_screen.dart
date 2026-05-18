// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class PswVisitChecklistScreen extends ConsumerStatefulWidget {
  const PswVisitChecklistScreen({super.key});

  @override
  ConsumerState<PswVisitChecklistScreen> createState() => _PswVisitChecklistScreenState();
}

class _PswVisitChecklistScreenState extends ConsumerState<PswVisitChecklistScreen> {
  final Map<String, bool> _tasks = {
    'Administer Morning Medication': true,
    'Check Blood Pressure': true,
    'Assist with Bathing': false,
    'Prepare Breakfast': false,
    'Light Housekeeping': false,
  };

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Task List & Checklist', style: theme.typography.h2),
            SizedBox(height: theme.spacing.xl),
            PrimeCareCard(
              padding: EdgeInsets.all(theme.spacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Eleanor Vance - Morning Visit', style: theme.typography.h3),
                          Text('10:00 AM - 12:00 PM', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface.withValues(alpha: 0.6))),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: theme.colors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'In Progress',
                          style: theme.typography.bodyLarge.copyWith(
                            color: theme.colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: theme.spacing.xl),
                  ..._tasks.entries.map((entry) => _buildChecklistItem(theme, entry.key, entry.value)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistItem(PrimeThemeData theme, String title, bool isChecked) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _tasks[title] = !_tasks[title]!;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(theme.spacing.md),
          decoration: BoxDecoration(
            color: isChecked ? theme.colors.success.withValues(alpha: 0.05) : theme.colors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isChecked ? theme.colors.success.withValues(alpha: 0.3) : theme.colors.border.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                isChecked ? LucideIcons.checkSquare : LucideIcons.square,
                color: isChecked ? theme.colors.success : theme.colors.onSurface.withValues(alpha: 0.4),
                size: 24,
              ),
              SizedBox(width: theme.spacing.md),
              Expanded(
                child: Text(
                  title,
                  style: theme.typography.bodyLarge.copyWith(
                    decoration: isChecked ? TextDecoration.lineThrough : null,
                    color: isChecked ? theme.colors.onSurface.withValues(alpha: 0.5) : theme.colors.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
