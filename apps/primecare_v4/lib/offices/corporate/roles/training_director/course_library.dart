import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class CourseLibraryScreen extends ConsumerWidget {
  const CourseLibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Course & Content Library',
      subtitle:
          'Manage SCORM packages, clinical training videos, quizzes, and continuing education modules.',
      headerTrailing: [
        ClinicalSearchTextField(hintText: 'Search thousands of courses...'),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Upload SCORM',
          icon: LucideIcons.upload,
        ),
        const SizedBox(width: 12),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Create Course',
          icon: LucideIcons.plus,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        KPICardData(
          title: 'Total Courses',
          value: '420',
          icon: LucideIcons.library,
          trend: '+12 added this month',
          isUp: true,
          color: PrimeCareTheme.colors.navyIndigo,
        ),
        KPICardData(
          title: 'Active Enrollments',
          value: '2,405',
          icon: LucideIcons.users,
          trend: 'Highest in Clinical Skills',
          isUp: true,
        ),
        KPICardData(
          title: 'Avg Course Rating',
          value: '4.7/5',
          icon: LucideIcons.star,
          trend: 'Based on 8,000+ reviews',
          isUp: true,
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
      ],
      sidebarContent: [
        _buildLibraryCategories(),
        const SizedBox(height: 24),
        _buildMostPopular(),
      ],
      mainContent: [_buildCourseGrid()],
    );
  }

  Widget _buildLibraryCategories() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.tags,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('Subject Categories', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildCatRow('Clinical Excellence', 184),
          const SizedBox(height: 12),
          _buildCatRow('Leadership & Mgmt', 45),
          const SizedBox(height: 12),
          _buildCatRow('Health & Safety', 92),
          const SizedBox(height: 12),
          _buildCatRow('Software & IT', 34),
          const SizedBox(height: 12),
          _buildCatRow('Soft Skills', 65),
        ],
      ),
    );
  }

  Widget _buildCatRow(String name, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: PrimeCareTheme.typography.body),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: PrimeCareTheme.colors.cloudGray,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(count.toString(), style: PrimeCareTheme.typography.label),
        ),
      ],
    );
  }

  Widget _buildMostPopular() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.flame,
                color: PrimeCareTheme.colors.amberWarning,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('Most Popular', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildPopularRow('Dementia Care Foundations', '4.9'),
          const SizedBox(height: 12),
          _buildPopularRow('Effective De-escalation', '4.8'),
          const SizedBox(height: 12),
          _buildPopularRow('Advanced Wound Care', '4.8'),
        ],
      ),
    );
  }

  Widget _buildPopularRow(String name, String rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            name,
            style: PrimeCareTheme.typography.body,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          children: [
            Icon(
              LucideIcons.star,
              size: 14,
              color: PrimeCareTheme.colors.amberWarning,
            ),
            const SizedBox(width: 4),
            Text(
              rating,
              style: PrimeCareTheme.typography.label.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCourseGrid() {
    return ClinicalGlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Course Catalog', style: PrimeCareTheme.typography.h2),
                Row(
                  children: [
                    ClinicalGlassButton(
                      onPressed: () {},
                      label: 'Sort: Newest',
                      icon: LucideIcons.arrowDownUp,
                    ),
                    const SizedBox(width: 12),
                    ClinicalGlassButton(
                      onPressed: () {},
                      label: 'Filters',
                      icon: LucideIcons.filter,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildCourseRow(
            id: 'CRS-402',
            title: 'Handling Aggressive Behaviors',
            category: 'Health & Safety',
            format: 'Video & Quiz (SCORM)',
            duration: '45 mins',
            status: 'Published',
          ),
          const Divider(height: 1),
          _buildCourseRow(
            id: 'CRS-405',
            title: 'Medication Administration v3',
            category: 'Clinical Excellence',
            format: 'Interactive Module',
            duration: '1h 30m',
            status: 'Draft',
          ),
          const Divider(height: 1),
          _buildCourseRow(
            id: 'CRS-510',
            title: 'Empathy in End-of-Life Care',
            category: 'Soft Skills',
            format: 'Seminar / Video',
            duration: '2 hours',
            status: 'Published',
          ),
        ],
      ),
    );
  }

  Widget _buildCourseRow({
    required String id,
    required String title,
    required String category,
    required String format,
    required String duration,
    required String status,
  }) {
    final isPublished = status == 'Published';
    final statusColor = isPublished
        ? PrimeCareTheme.colors.emeraldTeal
        : PrimeCareTheme.colors.slateGray;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              LucideIcons.playCircle,
              color: PrimeCareTheme.colors.navyIndigo,
              size: 24,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      id,
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(title, style: PrimeCareTheme.typography.h3),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      LucideIcons.tag,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(category, style: PrimeCareTheme.typography.label),
                    const SizedBox(width: 16),
                    Icon(
                      LucideIcons.monitor,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(format, style: PrimeCareTheme.typography.label),
                    const SizedBox(width: 16),
                    Icon(
                      LucideIcons.clock,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(duration, style: PrimeCareTheme.typography.label),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ClinicalGlassButton(
                onPressed: () {},
                label: 'Manage Content',
                icon: LucideIcons.settings,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
