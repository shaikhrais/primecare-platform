import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/clinical_glass_panel.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class StaffManagementScreen extends StatelessWidget {
  const StaffManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                   _buildKPIs(context),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                            children: [
                                _buildEmployeeDirectory(context),
                                const SizedBox(height: 24),
                                _buildPerformanceReviews(context),
                            ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildCertificationCompliance(context),
                            const SizedBox(height: 24),
                            _buildTurnoverRate(context),
                          ],
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

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Staff & HR Management',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Manage employee directory, certifications, reviews, and retention',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
        Row(
          children: [
            _buildActionIconButton(context, LucideIcons.userPlus, 'Onboard Staff'),
            const SizedBox(width: 12),
            _buildActionIconButton(context, LucideIcons.badgeCheck, 'Audit Certs'),
          ],
        ),
      ],
    );
  }

  Widget _buildActionIconButton(BuildContext context, IconData icon, String tooltip) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: () {},
        tooltip: tooltip,
      ),
    );
  }

  Widget _buildKPIs(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildKPIUnit(context, 'Total Franchise Staff', '142', LucideIcons.users, '+5 this month', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Certifications Expiring', '12', LucideIcons.fileWarning, 'Next 30 days', Colors.orange)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Avg Employee Tenure', '3.2y', LucideIcons.calendarCheck, '+0.4y YoY', PrimeCareTheme.emeraldTeal)),
        const SizedBox(width: 16),
        Expanded(child: _buildKPIUnit(context, 'Performance Reviews', '8', LucideIcons.clipboardList, 'Due this week', Colors.blue)),
      ],
    );
  }

  Widget _buildKPIUnit(BuildContext context, String title, String value, IconData icon, String subtitle, Color color) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
                color: color.withValues(alpha: 0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
            ),
           )
        ],
      ),
    );
  }

  Widget _buildEmployeeDirectory(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text(
                'Active Staff Directory',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                ),
                ),
                Container(
                    width: 250,
                    height: 40,
                    decoration: BoxDecoration(
                         color: Colors.white.withValues(alpha: 0.1),
                         borderRadius: BorderRadius.circular(8),
                    ),
                    child: const TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: 'Search by name or role...',
                            hintStyle: TextStyle(color: Colors.white54),
                            prefixIcon: Icon(LucideIcons.search, color: Colors.white54, size: 18),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                        )
                    )
                )
            ],
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
              dataTextStyle: const TextStyle(color: Colors.white),
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Role')),
                DataColumn(label: Text('Hire Date')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Profile')),
              ],
              rows: [
                _buildDataRow('Sarah Jenkins', 'RN', 'Mar 12, 2021', PrimeCareTheme.emeraldTeal, 'Active'),
                _buildDataRow('Mike Ross', 'PSW', 'Jun 05, 2023', PrimeCareTheme.emeraldTeal, 'Active'),
                _buildDataRow('Lisa Wong', 'LPN', 'Jan 10, 2024', Colors.orange, 'Leave (Maternity)'),
                _buildDataRow('John Smith', 'PSW', 'Nov 22, 2022', PrimeCareTheme.emeraldTeal, 'Active'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(String name, String role, String hireDate, Color statusColor, String status) {
    return DataRow(
      cells: [
        DataCell(Text(name, style: const TextStyle(fontWeight: FontWeight.w500))),
        DataCell(Text(role)),
        DataCell(Text(hireDate, style: const TextStyle(color: Colors.white70))),
        DataCell(
             Container(
                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                 decoration: BoxDecoration(
                     color: statusColor.withValues(alpha: 0.2),
                     borderRadius: BorderRadius.circular(12),
                     border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                 ),
                 child: Text(
                     status,
                     style: TextStyle(
                         color: statusColor,
                         fontSize: 12,
                         fontWeight: FontWeight.w500,
                     ),
                 ),
             )
        ),
        DataCell(
             TextButton(
                 onPressed: () {},
                 child: const Text('View', style: TextStyle(color: PrimeCareTheme.emeraldTeal, fontSize: 12)),
             )
        ),
      ],
    );
  }

    Widget _buildCertificationCompliance(BuildContext context) {
      return ClinicalGlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LucideIcons.fileBadge, color: PrimeCareTheme.emeraldTeal, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Certification Status',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildComplianceRow('CPR/First Aid', '100% Up to date', PrimeCareTheme.emeraldTeal, 1.0),
            const SizedBox(height: 16),
             _buildComplianceRow('Infection Control', '5 Expiring Soon', Colors.orange, 0.95),
            const SizedBox(height: 16),
             _buildComplianceRow('WHMIS Training', '2 Overdue', Colors.redAccent, 0.88),
          ],
        ),
      );
    }

     Widget _buildComplianceRow(String title, String status, Color color, double progress) {
        return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                 Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                         Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                         Text(status, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
                     ]
                 ),
                 const SizedBox(height: 8),
                ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.white12,
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                        minHeight: 4,
                    ),
                ),
             ]
        );
     }

    Widget _buildTurnoverRate(BuildContext context) {
      return ClinicalGlassPanel(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LucideIcons.trendingDown, color: PrimeCareTheme.emeraldTeal, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Retention Metrics (YTD)',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                    Expanded(child: _buildCategoryBar('Q1', 4, Colors.blue)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildCategoryBar('Q2', 6, Colors.orange)),
                     const SizedBox(width: 12),
                    Expanded(child: _buildCategoryBar('Q3', 3, PrimeCareTheme.emeraldTeal)),
                     const SizedBox(width: 12),
                    Expanded(child: _buildCategoryBar('Q4', 1, PrimeCareTheme.emeraldTeal)),
                ]
            ),
            const SizedBox(height: 24),
            Center(child: Text('Current Turnover Rate: 8.5% (Below Industry Avg)', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70))),
          ],
        ),
      );
    }

     Widget _buildCategoryBar(String label, double val, Color color) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                Text(val.toInt().toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                    height: val * 10,
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                    )
                ),
                const SizedBox(height: 8),
                Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 11)),
            ]
        );
     }

    Widget _buildPerformanceReviews(BuildContext context) {
         return ClinicalGlassPanel(
            padding: const EdgeInsets.all(24),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Row(
                        children: [
                            Icon(LucideIcons.clipboardSignature, color: Colors.blue, size: 24),
                            const SizedBox(width: 12),
                            Text(
                            'Upcoming Performance Reviews',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                            ),
                            ),
                             const Spacer(),
                            const Text('View Schedule', style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.bold))
                        ],
                    ),
                    const SizedBox(height: 24),
                    _buildReviewItem('Sarah J. (RN)', 'Annual Review', 'Oct 18, 14:00', PrimeCareTheme.emeraldTeal),
                    const Divider(color: Colors.white12, height: 24),
                    _buildReviewItem('Mike R. (PSW)', '6-Month Probation Check', 'Oct 20, 10:00', Colors.orange),
                    const Divider(color: Colors.white12, height: 24),
                    _buildReviewItem('Anna K. (Admin)', 'Quarterly Sync', 'Oct 22, 11:30', Colors.blue),
                ]
            )
        );
    }

    Widget _buildReviewItem(String name, String type, String date, Color dotColor) {
        return Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                 Container(
                     width: 10,
                     height: 10,
                     margin: const EdgeInsets.only(top: 4),
                     decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
                 ),
                 const SizedBox(width: 16),
                 Expanded(
                     child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                             Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                     Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                                     Text(date, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                                 ]
                             ),
                             const SizedBox(height: 4),
                             Text(type, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                         ]
                     )
                 )
             ]
        );
    }
}
