import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:flutter/services.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'psw_timesheet_detail_screen.dart';

class PswTimesheetScreen extends StatefulWidget {
  const PswTimesheetScreen({super.key});

  @override
  State<PswTimesheetScreen> createState() => _PswTimesheetScreenState();
}

class _PswTimesheetScreenState extends State<PswTimesheetScreen> {
  Map<String, dynamic>? _selectedPeriod;

  final List<Map<String, dynamic>> _payPeriods = [
    {
      'date': 'Oct 28',
      'shifts': 2,
      'hours': 10.5,
      'earnings': 315.00,
      'surge': true,
    },
    {
      'date': 'Oct 27',
      'shifts': 1,
      'hours': 8.0,
      'earnings': 200.00,
      'surge': false,
    },
    {
      'date': 'Oct 26',
      'shifts': 3,
      'hours': 12.0,
      'earnings': 360.00,
      'surge': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      body: MasterDetailLayout(
        isDetailActive: _selectedPeriod != null,
        onBackToMaster: () => setState(() => _selectedPeriod = null),
        masterList: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24, 8, 24, 120),
          child: PrimeCareColumn(
            children: [
              // Month High-Level Aggregation
              PrimeCareCard(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: EdgeInsets.all(24),
                child: PrimeCareColumn(
                  children: [
                    PrimeCareText(
                      'Est. October Payout',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    PrimeCareText(
                      '\$4,250.75',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1,
                      ),
                    ),
                    SizedBox(height: 24),
                    PrimeCareRow(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildMetric(context, 'Hours', '142.5'),
                        PrimeCareContainer(
                          width: 1,
                          height: 40,
                          color: PrimeCareColors.slate700,
                        ),
                        _buildMetric(context, 'Shifts', '22'),
                        PrimeCareContainer(
                          width: 1,
                          height: 40,
                          color: PrimeCareColors.slate700,
                        ),
                        _buildMetric(context, 'Surge OT', '18h'),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32),

              PrimeCareCard(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                child: PrimeCareColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimeCareText(
                      'Activity Heatmap',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        final intensity = (index % 5 == 0)
                            ? 0.8
                            : (index % 3 == 0)
                            ? 0.4
                            : 0.05;
                        return Container(
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).primaryColor.withValues(alpha: intensity),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '\${index + 1}',
                              style: TextStyle(
                                color: intensity > 0.3
                                    ? Colors.white
                                    : Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32),

              // Level 1 Daily Rows -> Drills directly to Level 2
              ..._payPeriods.map((period) {
                return PrimeCarePadding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      final isDesktop =
                          MediaQuery.of(context).size.width >= 800;
                      if (isDesktop) {
                        setState(() => _selectedPeriod = period);
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PswTimesheetDetailScreen(
                              date: period['date'],
                              earnings: period['earnings'],
                              surgeActive: period['surge'],
                            ),
                          ),
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: PrimeCareCard(
                      padding: EdgeInsets.all(20),
                      child: PrimeCareRow(
                        children: [
                          PrimeCareCard(
                            padding: EdgeInsets.all(12),

                            child: PrimeCareIcon(
                              Icons.receipt_long_rounded,
                              color: Color(0xFF475569),
                            ),
                          ),
                          SizedBox(width: 16),
                          PrimeCareExpanded(
                            child: PrimeCareColumn(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimeCareText(
                                  period['date'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                PrimeCareText(
                                  '${period['hours']} Hours • ${period['shifts']} Shifts',
                                  style: TextStyle(
                                    color: PrimeCareColors.slate500,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PrimeCareColumn(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              PrimeCareText(
                                '\$${period['earnings'].toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  color: Theme.of(
                                    context,
                                  ).textTheme.titleLarge?.color,
                                ),
                              ),
                              if (period['surge'])
                                PrimeCareText(
                                  'Surge +1.5x',
                                  style: TextStyle(
                                    color: PrimeCareColors.emerald,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(width: 8),
                          PrimeCareIcon(
                            Icons.arrow_forward_ios_rounded,
                            color: Theme.of(context).dividerColor,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        detailView: _selectedPeriod == null
            ? SizedBox.shrink()
            : PswTimesheetDetailScreen(
                date: _selectedPeriod!['date'],
                earnings: _selectedPeriod!['earnings'],
                surgeActive: _selectedPeriod!['surge'],
              ),
      ),
    );
  }

  Widget _buildMetric(BuildContext context, String label, String value) {
    return PrimeCareColumn(
      children: [
        PrimeCareText(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        PrimeCareText(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
