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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colors.primary.withValues(alpha: 0.16),
            theme.colors.primary.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.primary.withValues(alpha: 0.2)),
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
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colors.primary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LucideIcons.shieldCheck,
                      size: 24,
                      color: theme.colors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        roleName.toUpperCase(),
                        style: theme.typography.labelBold.copyWith(
                          color: theme.colors.primary,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Active & Secure',
                            style: theme.typography.bodySmall.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              if (onRefresh != null)
                IconButton(
                  icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary, size: 20),
                  onPressed: onRefresh,
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.typography.h2.copyWith(color: theme.colors.onBackground),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
          ),
        ],
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
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.divider),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: brandColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(theme.radiusSm),
                ),
                child: Icon(icon, color: brandColor, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  trendLabel,
                  style: theme.typography.bodySmall.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.typography.labelMedium.copyWith(color: theme.colors.onSurfaceVariant),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.typography.h2.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: theme.colors.divider,
              valueColor: AlwaysStoppedAnimation<Color>(brandColor),
              minHeight: 6,
            ),
          ),
        ],
      ),
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
        const SnackBar(content: Text('Operational Form Hydrated & Dispatched Successfully.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.divider),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: theme.typography.h3),
            const SizedBox(height: 16),
            ...widget.fields.map((field) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: PrimeCareTextField(
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
            // Upload mockup
            Text('Audit Ingestion Attachment', style: theme.typography.labelMedium),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _isUploading ? null : _simulateFileUpload,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.colors.background,
                  borderRadius: BorderRadius.circular(theme.radiusDefault),
                  border: Border.all(
                    color: theme.colors.outline,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  children: [
                    if (_isUploading) ...[
                      const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      const SizedBox(height: 8),
                      Text('Uploading securely to ledger...', style: theme.typography.bodySmall),
                    ] else if (_uploadedFileName != null) ...[
                      Icon(LucideIcons.fileCheck2, color: theme.colors.primary, size: 28),
                      const SizedBox(height: 8),
                      Text(
                        _uploadedFileName!,
                        style: theme.typography.bodyMedium.copyWith(
                          color: theme.colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text('Tap to replace attachment', style: theme.typography.bodySmall),
                    ] else ...[
                      Icon(LucideIcons.uploadCloud, color: theme.colors.onSurfaceVariant, size: 28),
                      const SizedBox(height: 8),
                      Text('Tap to attach encrypted audit PDF', style: theme.typography.bodyMedium),
                      Text('Maximum payload size: 25MB', style: theme.typography.bodySmall),
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
        border: Border.all(color: theme.colors.divider),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.title, style: theme.typography.h3),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: theme.colors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${filteredData.length} records',
                        style: theme.typography.bodySmall.copyWith(
                          color: theme.colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Search bar
                TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  style: theme.typography.bodyMedium,
                  decoration: InputDecoration(
                    hintText: 'Search audit records...',
                    prefixIcon: const Icon(LucideIcons.search, size: 18),
                    filled: true,
                    fillColor: theme.colors.background,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(theme.radiusDefault),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          if (filteredData.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: Column(
                  children: [
                    Icon(LucideIcons.database, size: 36, color: theme.colors.onSurfaceVariant),
                    const SizedBox(height: 12),
                    Text('No matching records found', style: theme.typography.h4),
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
                Color statusColor = Colors.green;
                if (status == 'Warning' || status == 'Pending') {
                  statusColor = theme.colors.warning;
                } else if (status == 'Alert' || status == 'Critical') {
                  statusColor = theme.colors.error;
                }

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          row[widget.columns[0]] ?? '',
                          style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          status,
                          style: theme.typography.bodySmall.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          row[widget.columns[1]] ?? '',
                          style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                        Text(
                          row['date'] ?? '',
                          style: theme.typography.bodySmall.copyWith(color: theme.colors.outline),
                        ),
                      ],
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
        border: Border.all(color: theme.colors.divider),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(widget.title, style: theme.typography.h3),
          ),
          const Divider(height: 1),
          ...widget.items.map((item) {
            final isSelected = _states[item.id] ?? false;
            return SwitchListTile.adaptive(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              activeTrackColor: theme.colors.primary.withValues(alpha: 0.5),
              activeThumbColor: theme.colors.primary,
              title: Text(
                item.name,
                style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                item.description,
                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
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

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.divider),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.typography.h3,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.trendingUp,
                      size: 14,
                      color: accentColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Live Telemetry',
                      style: theme.typography.bodySmall.copyWith(
                        color: accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Chart Graphic
          SizedBox(
            height: 120,
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
                            heightFactor: normalizedHeight.clamp(0.05, 1.0),
                            widthFactor: 0.6,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    accentColor,
                                    accentColor.withValues(alpha: 0.5),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(6),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        labels[index],
                        style: theme.typography.bodySmall.copyWith(
                          fontSize: 10,
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
    );
  }
}

