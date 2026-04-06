import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class ContentApprovalScreen extends ConsumerStatefulWidget {
  const ContentApprovalScreen({super.key});

  @override
  ConsumerState<ContentApprovalScreen> createState() => _ContentApprovalScreenState();
}

class _ContentApprovalScreenState extends ConsumerState<ContentApprovalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildKanbanBoard(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Content Approval Pipeline',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Review and approve marketing collateral, digital ads, and regional communications.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 250,
              child: ClinicalSearchTextField(hintText: 'Search content...'),
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              icon: LucideIcons.filter,
              label: 'Filter',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKanbanBoard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildColumn(
            title: 'Pending Review',
            icon: LucideIcons.clock,
            color: Colors.amber.shade700,
            items: [
              _buildApprovalCard(
                title: 'Q1 Flu Shot Campaign - Facebook Ad',
                type: 'Social Media',
                author: 'Sarah Jenkins',
                deadline: 'Tomorrow, 5:00 PM',
                category: 'Digital',
                isActionable: true,
              ),
              _buildApprovalCard(
                title: 'New Clinic Overview Brochure',
                type: 'Print Material',
                author: 'Mike Chen',
                deadline: 'Oct 28',
                category: 'Print',
                isActionable: true,
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildColumn(
            title: 'Revisions Requested',
            icon: LucideIcons.edit2,
            color: PrimeCareTheme.colors.coralRed,
            items: [
              _buildApprovalCard(
                title: 'Pediatric Care Landing Page Copy',
                type: 'Web Content',
                author: 'Emily Davis',
                deadline: 'Oct 29',
                category: 'Web',
                isActionable: false,
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildColumn(
            title: 'Approved',
            icon: LucideIcons.checkCircle,
            color: PrimeCareTheme.colors.emeraldTeal,
            items: [
              _buildApprovalCard(
                title: 'Holiday Email Template Options',
                type: 'Email Marketing',
                author: 'Sarah Jenkins',
                deadline: 'Completed',
                category: 'Email',
                isActionable: false,
              ),
              _buildApprovalCard(
                title: 'LinkedIn B2B Sponsored Post',
                type: 'Social Media',
                author: 'Alex Rivera',
                deadline: 'Completed',
                category: 'Digital',
                isActionable: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColumn({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> items,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLow.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: PrimeCareTheme.typography.h3.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  items.length.toString(),
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: item,
              )),
        ],
      ),
    );
  }

  Widget _buildApprovalCard({
    required String title,
    required String type,
    required String author,
    required String deadline,
    required String category,
    required bool isActionable,
  }) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  category,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(LucideIcons.moreHorizontal, size: 16, color: PrimeCareTheme.colors.slateGray),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: PrimeCareTheme.typography.body.copyWith(
              color: PrimeCareTheme.colors.navyIndigo,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            type,
            style: PrimeCareTheme.typography.label.copyWith(
              color: PrimeCareTheme.colors.slateGray,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: PrimeCareTheme.colors.navyIndigo.withValues(alpha: 0.1),
                radius: 12,
                child: Text(
                  author[0],
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                author,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(LucideIcons.calendar, size: 12, color: PrimeCareTheme.colors.slateGray),
              const SizedBox(width: 4),
              Text(
                'Due: $deadline',
                style: PrimeCareTheme.typography.label.copyWith(
                  color: isActionable ? PrimeCareTheme.colors.coralRed : PrimeCareTheme.colors.slateGray,
                  fontSize: 11,
                  fontWeight: isActionable ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
          if (isActionable) ...[
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: PrimeCareTheme.colors.coralRed,
                      side: BorderSide(color: PrimeCareTheme.colors.coralRed.withValues(alpha: 0.5)),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text('Reject', style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.emeraldTeal,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text('Approve', style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ],
            )
          ]
        ],
      ),
    );
  }
}
