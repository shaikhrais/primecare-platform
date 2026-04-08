import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RpnnursingNotesScreen extends ConsumerStatefulWidget {
  const RpnnursingNotesScreen({super.key});

  @override
  ConsumerState<RpnnursingNotesScreen> createState() =>
      _RpnnursingNotesScreenState();
}

class _RpnnursingNotesScreenState extends ConsumerState<RpnnursingNotesScreen> {
  final TextEditingController _sController = TextEditingController();
  final TextEditingController _oController = TextEditingController();
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _pController = TextEditingController();

  final List<String> _tags = [];

  @override
  void dispose() {
    _sController.dispose();
    _oController.dispose();
    _aController.dispose();
    _pController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Nursing Notes',
      subtitle: 'Complete SOAP documentation and review patient note history',
      icon: LucideIcons.fileText,
      actions: [
        IconButton(
          icon: const Icon(LucideIcons.printer),
          onPressed: () {},
          tooltip: 'Print Notes',
        ),
      ],
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side: Note History Feed
          Expanded(
            flex: 4,
            child: ClinicalGlassPanel(
              padding: const EdgeInsets.all(PrimeCareTheme.spacing4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent Notes', style: PrimeCareTheme.titleMedium),
                      IconButton(
                        icon: const Icon(LucideIcons.filter),
                        onPressed: () {},
                        color: PrimeCareTheme.primary,
                      ),
                    ],
                  ),
                  const SizedBox(height: PrimeCareTheme.spacing4),
                  // Search/Filter Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      PrimeCareTheme.radiusLg,
                    ),
                    child: ColoredBox(
                      color: PrimeCareTheme.surfaceContainerHighest.withOpacity(
                        0.3,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: PrimeCareTheme.spacing3,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              LucideIcons.search,
                              color: PrimeCareTheme.onSurfaceVariant,
                              size: 20,
                            ),
                            const SizedBox(width: PrimeCareTheme.spacing3),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search notes by keyword...',
                                  hintStyle: PrimeCareTheme.bodyMedium.copyWith(
                                    color: PrimeCareTheme.onSurfaceVariant,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                style: PrimeCareTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: PrimeCareTheme.spacing4),
                  Expanded(
                    child: ListView.separated(
                      itemCount: 4,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: PrimeCareTheme.spacing3),
                      itemBuilder: (context, index) {
                        return _buildNoteHistoryCard(index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: PrimeCareTheme.spacing4),
          // Right Side: Input Area (SOAP)
          Expanded(
            flex: 6,
            child: ClinicalGlassPanel(
              padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'New SOAP Note',
                        style: PrimeCareTheme.headlineSmall,
                      ),
                      Row(
                        children: [
                          Text(
                            'Draft Saved • 10:42 AM',
                            style: PrimeCareTheme.labelSmall.copyWith(
                              color: PrimeCareTheme.primaryFixedDim,
                            ),
                          ),
                          const SizedBox(width: PrimeCareTheme.spacing3),
                          IconButton(
                            icon: const Icon(LucideIcons.clock),
                            onPressed: () {},
                            tooltip: 'View Note Templates',
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: PrimeCareTheme.spacing5),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSoapSection(
                            'S',
                            'Subjective',
                            _sController,
                            'Patient statements, symptoms, and concerns...',
                          ),
                          const SizedBox(height: PrimeCareTheme.spacing4),
                          _buildSoapSection(
                            'O',
                            'Objective',
                            _oController,
                            'Vitals, physical findings, and measurable data...',
                          ),
                          const SizedBox(height: PrimeCareTheme.spacing4),
                          _buildSoapSection(
                            'A',
                            'Assessment',
                            _aController,
                            'Clinical interpretation of the above findings...',
                          ),
                          const SizedBox(height: PrimeCareTheme.spacing4),
                          _buildSoapSection(
                            'P',
                            'Plan',
                            _pController,
                            'Nursing interventions, discharge planning, and follow-up...',
                          ),
                          const SizedBox(height: PrimeCareTheme.spacing5),
                          Text(
                            'Clinical Tags',
                            style: PrimeCareTheme.titleSmall,
                          ),
                          const SizedBox(height: PrimeCareTheme.spacing3),
                          Wrap(
                            spacing: PrimeCareTheme.spacing2,
                            runSpacing: PrimeCareTheme.spacing2,
                            children: [
                              _buildTagChip('Post-Op', true),
                              _buildTagChip('Pain Management', false),
                              _buildTagChip('Fall Risk', true, isAlert: true),
                              ActionChip(
                                label: const Text('+ Add Tag'),
                                onPressed: () {},
                                backgroundColor:
                                    PrimeCareTheme.surfaceContainerHighest,
                                labelStyle: PrimeCareTheme.labelSmall.copyWith(
                                  color: PrimeCareTheme.primary,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    PrimeCareTheme.radiusFull,
                                  ),
                                ),
                                side: BorderSide.none,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: PrimeCareTheme.spacing4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: PrimeCareTheme.spacing4,
                            vertical: PrimeCareTheme.spacing3,
                          ),
                        ),
                        child: Text(
                          'Discard Draft',
                          style: PrimeCareTheme.titleSmall.copyWith(
                            color: PrimeCareTheme.error,
                          ),
                        ),
                      ),
                      const SizedBox(width: PrimeCareTheme.spacing3),
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              PrimeCareTheme.primary,
                              PrimeCareTheme.primaryContainer,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(
                            PrimeCareTheme.radiusLg,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: PrimeCareTheme.spacing5,
                              vertical: PrimeCareTheme.spacing3,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                PrimeCareTheme.radiusLg,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                LucideIcons.checkCircle,
                                color: PrimeCareTheme.onPrimary,
                                size: 20,
                              ),
                              const SizedBox(width: PrimeCareTheme.spacing2),
                              Text(
                                'Sign & Save Note',
                                style: PrimeCareTheme.titleSmall.copyWith(
                                  color: PrimeCareTheme.onPrimary,
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
        ],
      ),
    );
  }

  Widget _buildSoapSection(
    String letter,
    String title,
    TextEditingController controller,
    String hint,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: PrimeCareTheme.primaryFixed,
                borderRadius: BorderRadius.circular(PrimeCareTheme.radiusSm),
              ),
              child: Text(
                letter,
                style: PrimeCareTheme.titleMedium.copyWith(
                  color: PrimeCareTheme.onPrimaryFixed,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: PrimeCareTheme.spacing3),
            Text(title, style: PrimeCareTheme.titleSmall),
          ],
        ),
        const SizedBox(height: PrimeCareTheme.spacing2),
        ClipRRect(
          borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
          child: ColoredBox(
            color: PrimeCareTheme.surfaceContainerLowest,
            child: TextField(
              controller: controller,
              maxLines: 3,
              minLines: 3,
              style: PrimeCareTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: PrimeCareTheme.bodyMedium.copyWith(
                  color: PrimeCareTheme.onSurfaceVariant,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(PrimeCareTheme.spacing3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoteHistoryCard(int index) {
    final bool isHighlighted = index == 0;

    return Container(
      decoration: BoxDecoration(
        color: PrimeCareTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
        boxShadow: isHighlighted
            ? [
                BoxShadow(
                  color: PrimeCareTheme.primary.withOpacity(0.08),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Stack(
        children: [
          if (isHighlighted)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
                  gradient: RadialGradient(
                    center: const Alignment(-0.8, -0.8),
                    radius: 1.5,
                    colors: [
                      PrimeCareTheme.primaryFixed.withOpacity(0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(PrimeCareTheme.spacing4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('SOAP Note', style: PrimeCareTheme.titleMedium),
                    Row(
                      children: [
                        Icon(
                          LucideIcons.calendar,
                          size: 14,
                          color: PrimeCareTheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          index == 0
                              ? 'Today, 08:30 AM'
                              : 'Yesterday, 14:15 PM',
                          style: PrimeCareTheme.labelSmall.copyWith(
                            color: PrimeCareTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: PrimeCareTheme.spacing3),
                Text(
                  'Patient reported pain level 4/10 this morning. Vitals stable. Dressing changed on left calf wound. Area is clean and free of infection signs. Will continue monitoring fluid intake.',
                  style: PrimeCareTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: PrimeCareTheme.spacing3),
                Row(
                  children: [
                    _buildTagChip('Routine', false),
                    const SizedBox(width: PrimeCareTheme.spacing2),
                    _buildTagChip('Wound Care', false),
                    const Spacer(),
                    Text(
                      'Signed by S. Smith, RPN',
                      style: PrimeCareTheme.labelSmall.copyWith(
                        color: PrimeCareTheme.primaryFixedDim,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagChip(String label, bool isSelected, {bool isAlert = false}) {
    final bgColor = isAlert
        ? PrimeCareTheme.errorContainer
        : (isSelected
              ? PrimeCareTheme.primaryFixed
              : PrimeCareTheme.surfaceContainerHigh);

    final textColor = isAlert
        ? PrimeCareTheme.onErrorContainer
        : (isSelected
              ? PrimeCareTheme.onPrimaryFixed
              : PrimeCareTheme.onSurfaceVariant);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: PrimeCareTheme.spacing3,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(PrimeCareTheme.radiusFull),
      ),
      child: Text(
        label,
        style: PrimeCareTheme.labelSmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
