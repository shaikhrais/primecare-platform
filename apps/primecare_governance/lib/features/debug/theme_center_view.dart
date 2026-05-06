import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeCenterView extends ConsumerWidget {
  const ThemeCenterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final visionMode = ref.watch(auraVisionProvider);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(theme.spacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, ref, visionMode),
                SizedBox(height: theme.spacing.lg),
                
                _buildSection(context, 'Stitch Core Tokens', [
                  _buildTokenGrid(context),
                ]),

                _buildSection(context, 'Dynamic Color Palette', [
                  _buildColorPalette(context),
                ]),

                _buildSection(context, 'Typography Hierarchy', [
                  _buildTypographyScale(context),
                ]),

                _buildSection(context, 'Spacing & Layout Manifest', [
                  _buildSpacingManifest(context),
                ]),

                _buildSection(context, 'Glassmorphism Effects', [
                  Row(
                    children: [
                      Expanded(
                        child: ClinicalGlassPanel(
                          title: 'Frost Level 1',
                          child: Text(
                            'Subtle backdrop blur for content cards.', 
                            style: theme.typography.bodySmall.copyWith(color: Colors.white70)
                          ),
                        ),
                      ),
                      SizedBox(width: theme.spacing.md),
                      Expanded(
                        child: ClinicalGlassPanel(
                          title: 'Frost Level 2',
                          child: Text(
                            'Heavy blur for navigation elements.', 
                            style: theme.typography.bodySmall.copyWith(color: Colors.white70)
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),

                _buildSection(context, 'Component Radii', [
                  Wrap(
                    spacing: theme.spacing.md,
                    runSpacing: theme.spacing.md,
                    children: [
                      _buildRadiusCard(context, 'Small (4px)', 4),
                      _buildRadiusCard(context, 'Medium (8px)', 8),
                      _buildRadiusCard(context, 'Large (16px)', 16),
                      _buildRadiusCard(context, 'X-Large (24px)', 24),
                    ],
                  ),
                ]),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref, AuraVisionMode mode) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Google Stitch',
                  style: theme.typography.h1.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Design System & Theme Orchestration',
                  style: theme.typography.bodyMedium.copyWith(color: theme.colors.primary),
                ),
              ],
            ),
            Row(
              children: [
                _buildVisionToggle(ref, mode, AuraVisionMode.live, 'Live'),
                SizedBox(width: theme.spacing.sm),
                _buildVisionToggle(ref, mode, AuraVisionMode.blueprint, 'Blueprint'),
                SizedBox(width: theme.spacing.sm),
                PrimeCareButton(
                  onPressed: () {},
                  label: 'Re-Stitch UI',
                  icon: LucideIcons.wand2,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: theme.spacing.md),
        const SystemIntegrityManifest(),
      ],
    );
  }

  Widget _buildVisionToggle(WidgetRef ref, AuraVisionMode current, AuraVisionMode target, String label) {
    final isActive = current == target;
    return InkWell(
      onTap: () => ref.read(auraVisionProvider.notifier).setMode(target),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue.withValues(alpha: 0.2) : Colors.white10,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isActive ? Colors.blue : Colors.white24),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Colors.blue : Colors.white70,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashboardSectionHeader(title: title),
        SizedBox(height: theme.spacing.md),
        ...children,
        SizedBox(height: theme.spacing.xl),
      ],
    );
  }

  Widget _buildTokenGrid(BuildContext context) {
    final theme = context.theme;
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: theme.spacing.md,
      mainAxisSpacing: theme.spacing.md,
      childAspectRatio: 2.5,
      children: [
        _buildStatCard(context, 'Primary Seed', '#00E5FF', LucideIcons.palette),
        _buildStatCard(context, 'Corner Radius', '12px', LucideIcons.square),
        _buildStatCard(context, 'Grid Gutter', '${theme.spacing.md}px', LucideIcons.grid),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, IconData icon) {
    final theme = context.theme;
    return PrimeCareCard(
      child: Row(
        children: [
          Icon(icon, color: theme.colors.primary, size: 20),
          SizedBox(width: theme.spacing.sm),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.typography.labelSmall.copyWith(color: theme.colors.slate400)),
              Text(value, style: theme.typography.titleSmall.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorPalette(BuildContext context) {
    final theme = context.theme;
    return Column(
      children: [
        _buildColorRow(context, 'Brand Colors', [
          _buildColorBox(context, 'Primary', theme.colors.primary),
          _buildColorBox(context, 'Secondary', theme.colors.secondary),
          _buildColorBox(context, 'Accent', Colors.indigoAccent),
        ]),
        SizedBox(height: theme.spacing.md),
        _buildColorRow(context, 'Semantic Colors', [
          _buildColorBox(context, 'Success', theme.colors.success),
          _buildColorBox(context, 'Warning', theme.colors.warning),
          _buildColorBox(context, 'Error', theme.colors.error),
        ]),
        SizedBox(height: theme.spacing.md),
        _buildColorRow(context, 'Neutral Palette', [
          _buildColorBox(context, 'Surface', theme.colors.surface),
          _buildColorBox(context, 'Background', const Color(0xFF0F172A)),
          _buildColorBox(context, 'Muted', Colors.white10),
        ]),
      ],
    );
  }

  Widget _buildColorRow(BuildContext context, String label, List<Widget> boxes) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.typography.labelSmall.copyWith(color: theme.colors.slate400)),
        SizedBox(height: theme.spacing.sm),
        Row(children: boxes),
      ],
    );
  }

  Widget _buildColorBox(BuildContext context, String name, Color color) {
    final theme = context.theme;
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: theme.spacing.sm),
        padding: EdgeInsets.all(theme.spacing.sm),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: theme.typography.labelSmall.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
            Text(
              '#${color.value.toRadixString(16).toUpperCase().substring(2)}',
              style: theme.typography.labelSmall.copyWith(fontSize: 8, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypographyScale(BuildContext context) {
    final theme = context.theme;
    return PrimeCareCard(
      child: Column(
        children: [
          _buildTypeRow(context, 'Display Large', 'Systemic Operations', theme.typography.h1),
          const Divider(color: Colors.white10),
          _buildTypeRow(context, 'Heading Medium', 'High-Fidelity Surveillance', theme.typography.h3),
          const Divider(color: Colors.white10),
          _buildTypeRow(context, 'Body Regular', 'Standard operational text for platform workflows.', theme.typography.bodyMedium),
          const Divider(color: Colors.white10),
          _buildTypeRow(context, 'Label Small', 'LAST SYNC: 2m AGO', theme.typography.labelSmall),
        ],
      ),
    );
  }

  Widget _buildTypeRow(BuildContext context, String name, String sample, TextStyle style) {
    final theme = context.theme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(name, style: theme.typography.labelSmall.copyWith(color: theme.colors.slate400))),
          Expanded(child: Text(sample, style: style.copyWith(color: Colors.white))),
        ],
      ),
    );
  }

  Widget _buildSpacingManifest(BuildContext context) {
    final theme = context.theme;
    return PrimeCareCard(
      child: Column(
        children: [
          _buildSpacingRow(context, 'XS', theme.spacing.xs),
          _buildSpacingRow(context, 'SM', theme.spacing.sm),
          _buildSpacingRow(context, 'MD', theme.spacing.md),
          _buildSpacingRow(context, 'LG', theme.spacing.lg),
          _buildSpacingRow(context, 'XL', theme.spacing.xl),
          _buildSpacingRow(context, 'XXL', theme.spacing.xxl),
        ],
      ),
    );
  }

  Widget _buildSpacingRow(BuildContext context, String name, double value) {
    final theme = context.theme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(name, style: theme.typography.labelSmall.copyWith(color: theme.colors.slate400))),
          Text('${value}px', style: theme.typography.labelSmall),
          SizedBox(width: theme.spacing.md),
          Expanded(
            child: Container(
              height: 4,
              width: value,
              decoration: BoxDecoration(
                color: theme.colors.primary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
              alignment: Alignment.centerLeft,
              child: Container(
                width: value,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadiusCard(BuildContext context, String name, double radius) {
    final theme = context.theme;
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white24),
      ),
      child: Center(
        child: Text(name, textAlign: TextAlign.center, style: theme.typography.labelSmall.copyWith(color: Colors.white70)),
      ),
    );
  }
}
