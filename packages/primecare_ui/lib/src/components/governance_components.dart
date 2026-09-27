// Governance - Category: view | Purpose: [Component] - GovDashboardHero A premium header card with a gradient, role title, and security status.
import 'package:primecare_ui/primecare_ui.dart';

/// [Component] - GovDashboardHero
/// A premium header card with a gradient, role title, and security status.
class GovDashboardHero extends StatelessWidget {
  final String title;
  final String roleName;
  final String description;
  final VoidCallback? onRefresh;

  const GovDashboardHero({
    super.key,
    required this.title,
    required this.roleName,
    required this.description,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isTeal = theme.colors.primary.value == 0xFF0F766E;
    
    final gradientColors = [
      theme.colors.primary,
      isTeal ? const Color(0xFF115E59) : const Color(0xFF1E3A8A),
      const Color(0xFF0F172A), // Slate 900
    ];

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1.0 - value) * -15),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(theme.radiusMd),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          boxShadow: [
            BoxShadow(
              color: theme.colors.primary.withValues(alpha: 0.2),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                      ),
                      child: const Icon(
                        LucideIcons.shieldCheck,
                        size: 24,
                        color: Color(0xFF22C55E), // Neon success green
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          roleName.toUpperCase(),
                          style: theme.typography.labelBold.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                            letterSpacing: 1.5,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF22C55E),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF22C55E),
                                    blurRadius: 6,
                                    spreadRadius: 2,
                                  )
                                ]
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'ACTIVE & SECURE',
                              style: theme.typography.bodySmall.copyWith(
                                color: const Color(0xFF22C55E),
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                if (onRefresh != null)
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: onRefresh,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(LucideIcons.refreshCw, color: Colors.white, size: 18),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: theme.typography.h1.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: theme.typography.bodyMedium.copyWith(
                color: Colors.white.withValues(alpha: 0.75),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// [Component] - GovMetricCard
/// A premium KPI card with a trend indicator, metric value, and progress bar.
class GovMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String trendLabel;
  final double progress; // 0.0 to 1.0
  final IconData icon;
  final Color brandColor;

  const GovMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.trendLabel,
    required this.progress,
    required this.icon,
    required this.brandColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, animValue, child) {
        return Transform.translate(
          offset: Offset(0, (1.0 - animValue) * 20),
          child: Opacity(
            opacity: animValue,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(theme.radiusMd),
                border: Border.all(color: theme.colors.divider.withValues(alpha: 0.5)),
                boxShadow: [
                  BoxShadow(
                    color: brandColor.withValues(alpha: 0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                  const BoxShadow(
                    color: Color(0x0A1E3A8A),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: brandColor.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(theme.radiusSm),
                          border: Border.all(color: brandColor.withValues(alpha: 0.15)),
                        ),
                        child: Icon(icon, color: brandColor, size: 20),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: const Color(0xFFBBF7D0)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              LucideIcons.trendingUp,
                              size: 12,
                              color: Color(0xFF15803D),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              trendLabel,
                              style: theme.typography.bodySmall.copyWith(
                                color: const Color(0xFF15803D),
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: theme.typography.labelMedium.copyWith(
                      color: theme.colors.onSurfaceVariant,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: theme.typography.h2.copyWith(
                      fontWeight: FontWeight.w800,
                      color: theme.colors.onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Utilization',
                            style: theme.typography.bodySmall.copyWith(
                              color: theme.colors.outline,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            '${(progress * animValue * 100).toInt()}%',
                            style: theme.typography.bodySmall.copyWith(
                              color: brandColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          height: 8,
                          child: Stack(
                            children: [
                              Container(
                                color: theme.colors.divider.withValues(alpha: 0.3),
                              ),
                              FractionallySizedBox(
                                widthFactor: progress * animValue,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        brandColor,
                                        brandColor.withValues(alpha: 0.7),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// [Component] - GovIngestionForm
/// An interactive form designed for Forms charters.
class GovIngestionForm extends StatefulWidget {
  final String title;
  final String buttonLabel;
  final List<String> fields;
  final void Function(Map<String, String>) onSubmit;

  const GovIngestionForm({
    super.key,
    required this.title,
    required this.buttonLabel,
    required this.fields,
    required this.onSubmit,
  });

  @override
  State<GovIngestionForm> createState() => _GovIngestionFormState();
}

class _GovIngestionFormState extends State<GovIngestionForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  bool _isUploading = false;
  String? _uploadedFileName;

  @override
  void initState() {
    super.initState();
    for (final field in widget.fields) {
      _controllers[field] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _simulateFileUpload() async {
    setState(() => _isUploading = true);
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    setState(() {
      _isUploading = false;
      _uploadedFileName = 'governance_audit_attachment_${DateTime.now().millisecondsSinceEpoch}.pdf';
    });
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final values = _controllers.map((key, controller) => MapEntry(key, controller.text));
      if (_uploadedFileName != null) {
        values['attachment'] = _uploadedFileName!;
      }
      widget.onSubmit(values);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(LucideIcons.checkCircle2, color: Colors.white),
              SizedBox(width: 12),
              Text('Operational Form Hydrated & Dispatched Successfully.'),
            ],
          ),
          backgroundColor: Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.divider.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: const Color(0x05004AC6),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          const BoxShadow(
            color: Color(0x0A1E3A8A),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold, color: theme.colors.onSurface),
            ),
            const SizedBox(height: 20),
            ...widget.fields.map((field) => Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: PrimeCareTextField(
                    key: const Key('governance_components_textfield_input_1'),
                    label: field,
                    hintText: 'Enter secure ${field.toLowerCase()}...',
                    controller: _controllers[field],
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return '$field cannot be empty';
                      }
                      return null;
                    },
                  ),
                )),
            const SizedBox(height: 8),
            Text(
              'Audit Ingestion Attachment',
              style: theme.typography.labelMedium.copyWith(fontWeight: FontWeight.bold, color: theme.colors.onSurface),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _isUploading ? null : _simulateFileUpload,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.colors.background.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(theme.radiusDefault),
                  border: Border.all(
                    color: theme.colors.outline.withValues(alpha: 0.4),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  children: [
                    if (_isUploading) ...[
                      const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Uploading securely to ledger...',
                        style: theme.typography.bodySmall.copyWith(color: theme.colors.outline, fontWeight: FontWeight.bold),
                      ),
                    ] else if (_uploadedFileName != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colors.primary.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(LucideIcons.fileCheck2, color: theme.colors.primary, size: 28),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _uploadedFileName!,
                        style: theme.typography.bodyMedium.copyWith(
                          color: theme.colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Tap to replace attachment',
                        style: theme.typography.bodySmall.copyWith(color: theme.colors.outline),
                      ),
                    ] else ...[
                      Icon(LucideIcons.uploadCloud, color: theme.colors.outline, size: 32),
                      const SizedBox(height: 12),
                      Text(
                        'Tap to attach encrypted audit PDF',
                        style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.w600, color: theme.colors.onSurface),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Maximum payload size: 25MB',
                        style: theme.typography.bodySmall.copyWith(color: theme.colors.outline),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            PrimeButton.primary(
              label: widget.buttonLabel,
              isFullWidth: true,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

/// [Component] - GovComplianceAuditTable
/// A premium database list viewer with search highlights and filter badges.
class GovComplianceAuditTable extends StatefulWidget {
  final String title;
  final List<Map<String, String>> data;
  final List<String> columns;

  const GovComplianceAuditTable({
    super.key,
    required this.title,
    required this.data,
    required this.columns,
  });

  @override
  State<GovComplianceAuditTable> createState() => _GovComplianceAuditTableState();
}

class _GovComplianceAuditTableState extends State<GovComplianceAuditTable> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final filteredData = widget.data.where((row) {
      if (_searchQuery.isEmpty) return true;
      return row.values.any((val) => val.toLowerCase().contains(_searchQuery.toLowerCase()));
    }).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.divider.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: const Color(0x05004AC6),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          const BoxShadow(
            color: Color(0x0A1E3A8A),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: theme.typography.h3.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colors.onSurface,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: theme.colors.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: theme.colors.primary.withValues(alpha: 0.15)),
                      ),
                      child: Text(
                        '${filteredData.length} records',
                        style: theme.typography.bodySmall.copyWith(
                          color: theme.colors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  key: const Key('governance_components_textfield_input_2'),
                  onChanged: (val) => setState(() => _searchQuery = val),
                  style: theme.typography.bodyMedium,
                  decoration: InputDecoration(
                    hintText: 'Search audit records...',
                    prefixIcon: Icon(LucideIcons.search, size: 18, color: theme.colors.outline),
                    filled: true,
                    fillColor: theme.colors.background.withValues(alpha: 0.5),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(theme.radiusDefault),
                      borderSide: BorderSide(color: theme.colors.divider.withValues(alpha: 0.8)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(theme.radiusDefault),
                      borderSide: BorderSide(color: theme.colors.divider.withValues(alpha: 0.8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(theme.radiusDefault),
                      borderSide: BorderSide(color: theme.colors.primary, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          if (filteredData.isEmpty)
            Padding(
              padding: const EdgeInsets.all(48.0),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colors.background,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(LucideIcons.database, size: 40, color: theme.colors.outline),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No matching records found',
                      style: theme.typography.h4.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Try refiltering your search query',
                      style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredData.length,
              separatorBuilder: (context, idx) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final row = filteredData[index];
                final status = row['status'] ?? 'Secure';
                Color statusColor = const Color(0xFF15803D);
                Color statusBgColor = const Color(0xFFDCFCE7);
                Color statusBorderColor = const Color(0xFFBBF7D0);

                if (status == 'Warning' || status == 'Pending') {
                  statusColor = const Color(0xFFB45309);
                  statusBgColor = const Color(0xFFFEF3C7);
                  statusBorderColor = const Color(0xFFFDE68A);
                } else if (status == 'Alert' || status == 'Critical') {
                  statusColor = const Color(0xFFB91C1C);
                  statusBgColor = const Color(0xFFFEE2E2);
                  statusBorderColor = const Color(0xFFFECACA);
                }

                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  row[widget.columns[0]] ?? '',
                                  style: theme.typography.bodyLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colors.onSurface,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: statusBgColor,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: statusBorderColor),
                                ),
                                child: Text(
                                  status.toUpperCase(),
                                  style: theme.typography.bodySmall.copyWith(
                                    color: statusColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 9,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                row[widget.columns[1]] ?? '',
                                style: theme.typography.bodySmall.copyWith(
                                  color: theme.colors.onSurfaceVariant,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(LucideIcons.calendar, size: 12, color: theme.colors.outline),
                                  const SizedBox(width: 4),
                                  Text(
                                    row['date'] ?? '',
                                    style: theme.typography.bodySmall.copyWith(
                                      color: theme.colors.outline,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

/// [Component] - GovSettingsPanel
/// A premium settings config dashboard with switch-toggles.
class GovSettingsPanel extends StatefulWidget {
  final String title;
  final List<GovSettingsItem> items;
  final void Function(String, bool) onToggled;

  const GovSettingsPanel({
    super.key,
    required this.title,
    required this.items,
    required this.onToggled,
  });

  @override
  State<GovSettingsPanel> createState() => _GovSettingsPanelState();
}

class _GovSettingsPanelState extends State<GovSettingsPanel> {
  final Map<String, bool> _states = {};

  @override
  void initState() {
    super.initState();
    for (final item in widget.items) {
      _states[item.id] = item.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.divider.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: const Color(0x05004AC6),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          const BoxShadow(
            color: Color(0x0A1E3A8A),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              widget.title,
              style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold, color: theme.colors.onSurface),
            ),
          ),
          const Divider(height: 1),
          ...widget.items.map((item) {
            final isSelected = _states[item.id] ?? false;
            return SwitchListTile.adaptive(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              activeTrackColor: theme.colors.primary.withValues(alpha: 0.4),
              activeColor: theme.colors.primary,
              title: Text(
                item.name,
                style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: theme.colors.onSurface),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  item.description,
                  style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                ),
              ),
              value: isSelected,
              onChanged: (val) {
                setState(() => _states[item.id] = val);
                widget.onToggled(item.id, val);
              },
            );
          }),
        ],
      ),
    );
  }
}

class GovSettingsItem {
  final String id;
  final String name;
  final String description;
  final bool initialValue;

  const GovSettingsItem({
    required this.id,
    required this.name,
    required this.description,
    this.initialValue = false,
  });
}

/// [Component] - GovTelemetryChart
/// A premium, pure-canvas chart for rendering clean data points and trend lines.
class GovTelemetryChart extends StatelessWidget {
  final String title;
  final List<double> dataPoints;
  final List<String> labels;
  final Color accentColor;

  const GovTelemetryChart({
    super.key,
    required this.title,
    required this.dataPoints,
    required this.labels,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final maxVal = dataPoints.isNotEmpty
        ? dataPoints.reduce((a, b) => a > b ? a : b)
        : 1.0;

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutBack,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, animValue, child) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(theme.radiusMd),
            border: Border.all(color: theme.colors.divider.withValues(alpha: 0.5)),
            boxShadow: [
              BoxShadow(
                color: const Color(0x05004AC6),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
              const BoxShadow(
                color: Color(0x0A1E3A8A),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: theme.typography.h3.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colors.onSurface,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: accentColor.withValues(alpha: 0.15)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _PulseDot(color: accentColor),
                        const SizedBox(width: 6),
                        Text(
                          'LIVE TELEMETRY',
                          style: theme.typography.bodySmall.copyWith(
                            color: accentColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 9,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 140,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (index) => Container(
                        height: 1,
                        color: theme.colors.divider.withValues(alpha: 0.25),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(dataPoints.length, (index) {
                          final val = dataPoints[index];
                          final normalizedHeight = maxVal > 0 ? (val / maxVal) : 0.0;
                          return Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FractionallySizedBox(
                                      heightFactor: (normalizedHeight * animValue).clamp(0.06, 1.0),
                                      widthFactor: 0.45,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              accentColor,
                                              accentColor.withValues(alpha: 0.65),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          borderRadius: const BorderRadius.vertical(
                                            top: Radius.circular(8),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: accentColor.withValues(alpha: 0.25),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  labels[index],
                                  style: theme.typography.bodySmall.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: theme.colors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PulseDot extends StatefulWidget {
  final Color color;
  const _PulseDot({required this.color});

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 8 + (_controller.value * 8),
              height: 8 + (_controller.value * 8),
              decoration: BoxDecoration(
                color: widget.color.withValues(alpha: 0.4 * (1.0 - _controller.value)),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
              ),
            ),
          ],
        );
      },
    );
  }
}

