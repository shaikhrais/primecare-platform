import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';
import 'package:flutter_core/theme/prime_semantic_palette.dart';

Widget presentationPaletteFixture0(BuildContext context, IconData icon, String text, bool isActive) {
  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: isActive ? PrimeSemanticPalette.of(context, PrimeSemanticTone.primary).accent : Theme.of(context).colorScheme.surface.withValues(alpha: 0), // Sky 600
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                PrimeIcon(
                  icon,
                  color: isActive ? PrimeSemanticPalette.of(context, PrimeSemanticTone.primary).onAccent : Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 16,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PrimeText(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isActive ? PrimeSemanticPalette.of(context, PrimeSemanticTone.primary).onAccent : Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 12,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget presentationPaletteFixture1(BuildContext context, String name, int index) {
  final colors = [
    PrimeSemanticPalette.of(context, PrimeSemanticTone.primary).accent, // Red
    PrimeSemanticPalette.of(context, PrimeSemanticTone.secondary).accent, // Orange
    PrimeSemanticPalette.of(context, PrimeSemanticTone.secondary).accent, // Yellow
    PrimeSemanticPalette.of(context, PrimeSemanticTone.primary).accent, // Green
    PrimeSemanticPalette.of(context, PrimeSemanticTone.primary).accent, // Cyan
    PrimeSemanticPalette.of(context, PrimeSemanticTone.primary).accent, // Blue
    PrimeSemanticPalette.of(context, PrimeSemanticTone.secondary).accent, // Purple
    PrimeSemanticPalette.of(context, PrimeSemanticTone.secondary).accent, // Pink
  ];
  final initials = name.split(' ').map((e) => e[0]).take(2).join('').toUpperCase();
  return Container(
    width: 24,
    height: 24,
    decoration: BoxDecoration(
      color: PrimeSemanticPalette.tint(context, colors[index % colors.length]),
      shape: BoxShape.circle,
      border: Border.all(color: colors[index % colors.length], width: 1.5),
    ),
    alignment: Alignment.center,
    child: PrimeText(
      initials,
      style: TextStyle(
        color: PrimeSemanticPalette.onTint(context, colors[index % colors.length]),
        fontWeight: FontWeight.bold,
        fontSize: 10,
      ),
    ),
  );
}

Widget presentationPaletteFixture2(BuildContext context, String text, String type) {
  Color bg = PrimeSemanticPalette.of(context, PrimeSemanticTone.muted).surface;
  Color fg = PrimeSemanticPalette.of(context, PrimeSemanticTone.muted).onSurface;

  if (type == 'success') {
    bg = PrimeSemanticPalette.of(context, PrimeSemanticTone.success).surface;
    fg = PrimeSemanticPalette.of(context, PrimeSemanticTone.success).onSurface;
  } else if (type == 'warning') {
    bg = PrimeSemanticPalette.of(context, PrimeSemanticTone.warning).surface;
    fg = PrimeSemanticPalette.of(context, PrimeSemanticTone.warning).onSurface;
  } else if (type == 'danger') {
    bg = PrimeSemanticPalette.of(context, PrimeSemanticTone.error).surface;
    fg = PrimeSemanticPalette.of(context, PrimeSemanticTone.error).onSurface;
  } else if (type == 'info') {
    bg = PrimeSemanticPalette.of(context, PrimeSemanticTone.primary).surface;
    fg = PrimeSemanticPalette.of(context, PrimeSemanticTone.primary).onSurface;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: PrimeText(
      text,
      style: TextStyle(
        color: fg,
        fontSize: 10,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget presentationPaletteFixture3(BuildContext context, List<Map<String, String>> cards) {
  return Row(
    children: cards.map((c) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withValues(alpha: 0.02),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimeText(
                c['label']!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              PrimeText(
                c['value']!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  PrimeIcon(
                    c['trend'] == 'up' ? LucideIcons.trendingUp : LucideIcons.trendingDown,
                    color: c['trend'] == 'up' ? PrimeSemanticPalette.of(context, PrimeSemanticTone.success).onBase : PrimeSemanticPalette.of(context, PrimeSemanticTone.error).onBase,
                    size: 12,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: PrimeText(
                      c['change']!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: c['trend'] == 'up' ? PrimeSemanticPalette.of(context, PrimeSemanticTone.success).onBase : PrimeSemanticPalette.of(context, PrimeSemanticTone.error).onBase,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

Widget presentationPaletteFixture4(BuildContext context, {required String title, required Widget child}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 20),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).shadowColor.withValues(alpha: 0.02),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
          ),
          child: PrimeText(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: child,
        ),
      ],
    ),
  );
}

Widget presentationPaletteFixture5(BuildContext context, List<double> values, List<String> labels, Color color) {
  double maxVal = values.reduce((curr, next) => curr > next ? curr : next);
  return Container(
    height: 150,
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(values.length, (idx) {
        double pct = maxVal == 0 ? 0 : values[idx] / maxVal;
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  width: 32,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 24,
                    height: 120 * pct,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [color.withOpacity(0.6), color],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              PrimeText(
                labels[idx],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }),
    ),
  );
}

Widget presentationPaletteFixture6(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      presentationPaletteFixture3(context, [
        {'label': 'Revenue This Month', 'value': '\$184,250', 'trend': 'up', 'change': '+12.4% vs last month'},
        {'label': 'Payroll Pending', 'value': '27 Approvals', 'trend': 'down', 'change': 'Requires CFO sign-off'},
        {'label': 'Tax Filing Status', 'value': 'Ready', 'trend': 'up', 'change': 'Q2 HST remit calculated'},
        {'label': 'Consolidated Cash Balance', 'value': '\$1,245,000', 'trend': 'up', 'change': 'Bank account reconciled'},
      ]),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: presentationPaletteFixture4(context,
              title: 'Monthly Cash Inflow and Invoices Status',
              child: presentationPaletteFixture5(context, [30, 45, 60, 55, 80, 95], ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'], PrimeSemanticPalette.of(context, PrimeSemanticTone.primary).accent),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: presentationPaletteFixture4(context,
              title: 'Recent Executive Log Actions',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(5, (idx) {
                  final actions = [
                    'Payroll approved for Toronto Allied',
                    'Tax liability forms generated for CRA',
                    'Plaid bank sync complete for ledger',
                    'Invoice collection notice dispatched',
                    'Strategic financial report locked'
                  ];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimeIcon(LucideIcons.checkCircle2, color: PrimeSemanticPalette.of(context, PrimeSemanticTone.success).onBase, size: 14),
                        const SizedBox(width: 8),
                        Expanded(
                          child: PrimeText(
                            actions[idx],
                            style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
      presentationPaletteFixture4(context,
        title: 'Action Queue — Pending High Priority Invoices & Reimbursements',
        child: Table(
          border: TableBorder.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
          columnWidths: const {
            0: FlexColumnWidth(1.2),
            1: FlexColumnWidth(2.5),
            2: FlexColumnWidth(1.5),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(1.5),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerLow),
              children: [
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Tx ID', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Debit Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
            ...List.generate(8, (idx) {
              final amounts = [12450.0, 8900.0, 18450.0, 4200.0, 68500.0, 14200.0, 24500.0, 51210.0];
              final descriptions = [
                'Approve Sanitization supplies bulk',
                'Client invoice reconciliation batch #42',
                'HST Tax Remittance Adjusting Provision',
                'Corporate rent payment - HQ Office',
                'Clinical Staff Payroll - Bi-Weekly',
                'Corporate Supply Ingestion (Supplies)',
                'Franchise Royalty Inflow #104',
                'CRA Tax Filing Remittance Q2'
              ];
              final accounts = [
                '5040 - Medical Supplies',
                '1200 - Accounts Receivable',
                '2200 - GST/HST Payable',
                '5020 - Corporate Rent',
                '5010 - Wages & Salaries',
                '5040 - Medical Supplies',
                '4010 - Royalty Revenue',
                '2200 - GST/HST Payable'
              ];
              final statuses = ['balanced', 'balanced', 'balanced', 'balanced', 'balanced', 'discrepancy', 'balanced', 'balanced'];
              return TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('TX-2026-00${idx+1}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(descriptions[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(accounts[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${amounts[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: presentationPaletteFixture2(context,
                      statuses[idx].toUpperCase(),
                      statuses[idx] == 'balanced' ? 'success' : 'warning',
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    ],
  );
}

Widget presentationPaletteFixture7(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      presentationPaletteFixture3(context, [
        {'label': 'Operating Margin', 'value': '34.2%', 'trend': 'up', 'change': '+2.1% YoY growth'},
        {'label': 'Cost Reduction YTD', 'value': '-\$45,800', 'trend': 'up', 'change': 'Medical supplier renegotiations'},
        {'label': 'Forecast Accuracy', 'value': '98.4%', 'trend': 'up', 'change': 'AI Cash Flow projections'},
        {'label': 'Branch Discrepancies', 'value': '0', 'trend': 'down', 'change': 'All ledgers verified'},
      ]),
      Row(
        children: [
          Expanded(
            child: presentationPaletteFixture4(context,
              title: 'Consolidated Expense Forecast vs Actual',
              child: presentationPaletteFixture5(context, [50, 60, 48, 72, 85, 90], ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'], PrimeSemanticPalette.of(context, PrimeSemanticTone.secondary).accent),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: presentationPaletteFixture4(context,
              title: 'Revenue Projection 12-Month Outlook',
              child: presentationPaletteFixture5(context, [80, 85, 95, 110, 120, 135], ['Q1', 'Q2', 'Q3', 'Q4', 'Q1-27', 'Q2-27'], PrimeSemanticPalette.of(context, PrimeSemanticTone.success).accent),
            ),
          ),
        ],
      ),
      presentationPaletteFixture4(context,
        title: 'Detailed KPI Performance Matrix',
        child: Table(
          border: TableBorder.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerLow),
              children: [
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Indicator KPI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Target Value', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Current Value', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
            ...List.generate(8, (idx) {
              final indicators = [
                'Gross Profit Margin',
                'EBITDA Yield',
                'Days Sales Outstanding (DSO)',
                'Accounts Payable Turnover',
                'Cash Conversion Cycle',
                'Tax Filing Compliance Rate',
                'Audit Trail Cleared Ratio',
                'Operational Overhead Rate'
              ];
              final targets = ['70.0%', '\$450k', '25 Days', '8.0x', '30 Days', '100%', '100%', '<15%'];
              final currents = ['72.4%', '\$480k', '22 Days', '8.4x', '28 Days', '100%', '100%', '12.8%'];
              return TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(indicators[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(targets[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(currents[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: presentationPaletteFixture2(context, 'OPTIMAL', 'success'),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    ],
  );
}

Widget presentationPaletteFixture8(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      presentationPaletteFixture3(context, [
        {'label': 'Pending Approvals', 'value': '12 Invoices', 'trend': 'down', 'change': '-4 processed in last 2h'},
        {'label': 'Average SLA Time', 'value': '4.2 Hours', 'trend': 'up', 'change': '99.8% compliance level'},
        {'label': 'Triggered Audits', 'value': '0 Alerts', 'trend': 'down', 'change': 'Secure ledger validation'},
        {'label': 'Rejected Claims', 'value': '2 Batches', 'trend': 'up', 'change': 'Returned to billing admin'},
      ]),
      presentationPaletteFixture4(context,
        title: 'Active CFO Approval & Reconciliation Workflows',
        child: Table(
          border: TableBorder.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
          columnWidths: const {
            0: FlexColumnWidth(1.2),
            1: FlexColumnWidth(2.5),
            2: FlexColumnWidth(1.5),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(1.2),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerLow),
              children: [
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Workflow ID', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Process Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Initiator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Priority', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Workflow State', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
            ...List.generate(8, (idx) {
              final workflowNames = [
                'Payroll Approval Batch - June 2026',
                'Supplier Payout - Sanitization Supplies',
                'GST/HST Remittance CRA Submission',
                'Corporate Lease Settlement - HQ Office',
                'Plaid Reconciliation Variance Review',
                'Allied Health Contractor Payout #82',
                'Insurance Billing Claims Batch Audit',
                'Director Expense Report Review'
              ];
              final initiators = [
                'HR Admin (System)',
                'Accounts Payable Lead',
                'Tax Accountant (Internal)',
                'Real Estate Liaison',
                'Automated Ledger Bot',
                'Clinical Registry Manager',
                'Billing Supervisor',
                'Operations VP Office'
              ];
              final priorities = ['URGENT', 'HIGH', 'HIGH', 'MEDIUM', 'URGENT', 'HIGH', 'MEDIUM', 'LOW'];
              final statusBadges = ['WAITING_SIGN', 'PENDING_BANK', 'VERIFIED', 'COMPLETED', 'DISCREPANCY', 'WAITING_SIGN', 'AUDIT_RUN', 'COMPLETED'];
              return TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('WF-2026-90${idx+1}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(workflowNames[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(initiators[idx], style: const TextStyle(fontSize: 11))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: presentationPaletteFixture2(context,
                      priorities[idx],
                      priorities[idx] == 'URGENT' ? 'danger' : (priorities[idx] == 'HIGH' ? 'warning' : 'info'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: presentationPaletteFixture2(context,
                      statusBadges[idx],
                      statusBadges[idx] == 'COMPLETED' || statusBadges[idx] == 'VERIFIED' ? 'success' : 'warning',
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    ],
  );
}

Widget presentationPaletteFixture9(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      presentationPaletteFixture3(context, [
        {'label': 'Gross Inflows YTD', 'value': '\$1,842,500', 'trend': 'up', 'change': '+14.6% year-over-year'},
        {'label': 'Client Copayments', 'value': '\$84,250', 'trend': 'up', 'change': '96% collection efficiency'},
        {'label': 'Royalty Revenue', 'value': '\$120,400', 'trend': 'up', 'change': '12 active branches'},
        {'label': 'Outstanding Invoices', 'value': '\$28,490', 'trend': 'down', 'change': '30-day collection cycle'},
      ]),
      presentationPaletteFixture4(context,
        title: 'Monthly Cash Inflow Streams (Consolidated)',
        child: presentationPaletteFixture5(context, [85, 98, 120, 115, 142, 184], ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'], PrimeSemanticPalette.of(context, PrimeSemanticTone.success).accent),
      ),
      presentationPaletteFixture4(context,
        title: 'Revenue Sources Detail Logs',
        child: Table(
          border: TableBorder.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerLow),
              children: [
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Transaction Ref', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Source Origin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Plaid Account Match', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Amount Recd', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Ledger Sync', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
            ...List.generate(8, (idx) {
              final origins = [
                'Sun Life Insurance Batch Payout',
                'Franchise Licensing Fee (Ottawa West)',
                'Franchise Royalty (Toronto West)',
                'Patient Co-Pay Reconcile batch #110',
                'Green Shield Medical Claims Clearing',
                'Ontario Health Insurance (OHIP) Payout',
                'Private Care Client Direct EFT Inflow',
                'Private Care Contract Deposit Batch'
              ];
              final accounts = [
                '1010 - Operations Checking',
                '1010 - Corporate Reserves',
                '1010 - Corporate Reserves',
                '1010 - Patient Clearing',
                '1010 - Operations Checking',
                '1010 - Government Clearing',
                '1010 - Operations Checking',
                '1010 - Operations Checking'
              ];
              final amounts = [42500.0, 15000.0, 24500.0, 4890.0, 18240.0, 112500.0, 3200.0, 8900.0];
              return TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('REV-2026-00${idx+1}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(origins[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(accounts[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${amounts[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: presentationPaletteFixture2(context, 'BALANCED', 'success'),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    ],
  );
}

Widget presentationPaletteFixture10(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      presentationPaletteFixture3(context, [
        {'label': 'Total Expenses YTD', 'value': '\$542,800', 'trend': 'up', 'change': 'Within +/- 2% budget margins'},
        {'label': 'Supplier Liabilities', 'value': '\$12,400', 'trend': 'down', 'change': 'Bulk discount negotiated'},
        {'label': 'Wages & Salaries', 'value': '\$184,250', 'trend': 'up', 'change': 'All Allied Health payroll run'},
        {'label': 'Discrepancy Alerts', 'value': '1 Flag', 'trend': 'up', 'change': 'Plaid Ledger sync audit notice'},
      ]),
      presentationPaletteFixture4(context,
        title: 'Monthly Cash Outflow Expenses',
        child: presentationPaletteFixture5(context, [52, 60, 58, 48, 62, 74], ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'], PrimeSemanticPalette.of(context, PrimeSemanticTone.secondary).accent),
      ),
      presentationPaletteFixture4(context,
        title: 'Corporate Outflow Expenses Ledger',
        child: Table(
          border: TableBorder.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerLow),
              children: [
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Voucher ID', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Vendor Category', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Ledger Offset', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Amount Paid', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Remit Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
            ...List.generate(8, (idx) {
              final categories = [
                'Sanitization Supplies (Bulk)',
                'Telus Health Portal Monthly Sub',
                'PSWs Mileage & Expense (Peel Region)',
                'HQ Office Corporate Rent',
                'Medical Equipment Lease Payment',
                'Allied Health Contractor Fee Payout',
                'Tax Audit Consultant Retainer',
                'Plaid API Sync License Cost'
              ];
              final offsets = [
                '5040 - Medical Supplies',
                '5050 - IT & Software License',
                '5030 - Travel & Transportation',
                '5020 - Corporate Rent',
                '5060 - Equipment Rental',
                '5010 - Wages & Salaries',
                '5080 - Professional Fees',
                '5050 - IT & Software License'
              ];
              final amounts = [12400.0, 480.0, 8240.0, 4200.0, 1850.0, 68500.0, 3500.0, 120.0];
              final statuses = ['balanced', 'balanced', 'balanced', 'balanced', 'balanced', 'balanced', 'balanced', 'discrepancy'];
              return TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('EXP-2026-80${idx+1}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(categories[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(offsets[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${amounts[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: presentationPaletteFixture2(context,
                      statuses[idx].toUpperCase(),
                      statuses[idx] == 'balanced' ? 'success' : 'warning',
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    ],
  );
}

Widget presentationPaletteFixture11(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      presentationPaletteFixture3(context, [
        {'label': 'Active Employees', 'value': '245 Staff', 'trend': 'up', 'change': '+12 new hires this period'},
        {'label': 'Total Payroll Run', 'value': '\$124,500', 'trend': 'up', 'change': 'Bi-weekly billing cycle'},
        {'label': 'Pending Approvals', 'value': '27 Approvals', 'trend': 'down', 'change': 'Awaiting CFO authorization'},
        {'label': 'Average Hour Rate', 'value': '\$42.50/hr', 'trend': 'up', 'change': 'Standard Allied Health rate'},
      ]),
      presentationPaletteFixture4(context,
        title: 'Clinical Allied Health Staff Payroll Registry (Active Period)',
        child: Table(
          border: TableBorder.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
          columnWidths: const {
            0: FlexColumnWidth(0.5),
            1: FlexColumnWidth(1.8),
            2: FlexColumnWidth(1.5),
            3: FlexColumnWidth(0.8),
            4: FlexColumnWidth(1.2),
            5: FlexColumnWidth(1.2),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerLow),
              children: [
                Padding(padding: EdgeInsets.all(10), child: PrimeText('User', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Employee Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Branch Role', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Hours', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Gross Pay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Audit Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
            ...List.generate(8, (idx) {
              final names = [
                'John Smith',
                'Amara Okafor',
                'Carlos Santana',
                'Elena Rostova',
                'David Kim',
                'Beatrix Kiddo',
                'Liam Neeson',
                'Aisha Rahman'
              ];
              final roles = [
                'Registered Massage Therapist (RMT)',
                'Physiotherapist Lead',
                'Personal Support Worker (PSW)',
                'Registered Practical Nurse (RPN)',
                'Occupational Therapist',
                'Kinesiologist Practitioner',
                'Senior Caregiver',
                'Speech Pathologist Consultant'
              ];
              final hours = [72.5, 80.0, 95.0, 76.5, 64.0, 80.0, 88.0, 40.0];
              final rates = [45.0, 60.0, 28.0, 48.0, 52.0, 42.0, 32.0, 65.0];
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: Center(child: presentationPaletteFixture1(context, names[idx], idx)),
                  ),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(names[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(roles[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(hours[idx].toString(), style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${(hours[idx]*rates[idx]).toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: presentationPaletteFixture2(context,
                      idx == 4 ? 'DISCREPANCY' : 'APPROVED',
                      idx == 4 ? 'warning' : 'success',
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PrimeOutlinedButton(
              onPressed: () {},
              child: const PrimeText('Export Payroll Audit Report'),
            ),
            const SizedBox(width: 12),
            PrimeElevatedButton(
              style: PrimeElevatedButton.styleFrom(backgroundColor: PrimeSemanticPalette.of(context, PrimeSemanticTone.success).accent),
              onPressed: () {},
              child: PrimeText('Approve All Batches Sign-off', style: TextStyle(color: PrimeSemanticPalette.of(context, PrimeSemanticTone.success).onAccent)),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget presentationPaletteFixture12(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      presentationPaletteFixture3(context, [
        {'label': 'Total Invoiced', 'value': '\$213,890', 'trend': 'up', 'change': '+8.2% vs previous period'},
        {'label': 'Collected Balance', 'value': '\$185,400', 'trend': 'up', 'change': 'Outstanding amount: \$28,490'},
        {'label': 'Pending Insurance', 'value': '\$18,240', 'trend': 'down', 'change': 'Awaiting clearing validation'},
        {'label': 'Overdue Accounts', 'value': '4 Clients', 'trend': 'down', 'change': 'Automatic collection notice active'},
      ]),
      presentationPaletteFixture4(context,
        title: 'Receivables Invoice Control Hub',
        child: Table(
          border: TableBorder.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
          columnWidths: const {
            0: FlexColumnWidth(1.0),
            1: FlexColumnWidth(2.0),
            2: FlexColumnWidth(1.2),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(1.2),
            5: FlexColumnWidth(1.2),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerLow),
              children: [
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Invoice #', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Client Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Date Issued', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Amount Due', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Outstanding', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Filing Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
            ...List.generate(8, (idx) {
              final accounts = [
                'Sun Life Financial Claims #1092',
                'John Smith (Lower Back Therapy)',
                'Amara Okafor (Physio Intake)',
                'Green Shield Canada Clearing #45B',
                'Carlos Santana (Palliative Care)',
                'Elena Rostova (Home Care Package)',
                'David Kim (Rehab Sessions)',
                'Winnipeg West Regional Care Board'
              ];
              final dates = ['June 22', 'June 21', 'June 20', 'June 18', 'June 15', 'June 14', 'June 10', 'June 05'];
              final amounts = [42500.0, 245.0, 185.0, 18240.0, 1420.0, 3200.0, 480.0, 24500.0];
              final outstanding = [0.0, 245.0, 0.0, 18240.0, 0.0, 0.0, 480.0, 0.0];
              final statuses = ['PAID', 'UNPAID', 'PAID', 'PENDING', 'PAID', 'PAID', 'OVERDUE', 'PAID'];
              return TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('INV-2026-0${idx+100}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(accounts[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(dates[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${amounts[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${outstanding[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: presentationPaletteFixture2(context,
                      statuses[idx],
                      statuses[idx] == 'PAID' ? 'success' : (statuses[idx] == 'PENDING' ? 'info' : 'danger'),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    ],
  );
}

Widget presentationPaletteFixture13(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      presentationPaletteFixture3(context, [
        {'label': 'GST/HST Collected', 'value': '\$85,420', 'trend': 'up', 'change': 'Corporate Sales Revenue Q2'},
        {'label': 'Paid Input Tax Credits (ITC)', 'value': '\$34,210', 'trend': 'down', 'change': 'Supplier expenses offset'},
        {'label': 'Net CRA Remittance Due', 'value': '\$51,210', 'trend': 'up', 'change': 'Filing Period: Q2-2026'},
        {'label': 'Remittance Status', 'value': 'Ready', 'trend': 'up', 'change': 'Awaiting bank transfer sign-off'},
      ]),
      presentationPaletteFixture4(context,
        title: 'GST/HST Compliance Posting Ledger',
        child: Table(
          border: TableBorder.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerLow),
              children: [
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Posting Period', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('CRA Account Ref', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Collected Tax', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Offset Credits', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Net Tax Due', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Remit Sign', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
            ...List.generate(8, (idx) {
              final periods = ['Q2-2026', 'Q1-2026', 'Q4-2025', 'Q3-2025', 'Q2-2025', 'Q1-2025', 'Q4-2024', 'Q3-2024'];
              final collected = [85420.0, 78900.0, 92100.0, 84200.0, 72500.0, 68000.0, 81000.0, 74200.0];
              final paidItc = [34210.0, 31000.0, 42000.0, 35000.0, 28000.0, 26000.0, 33000.0, 29000.0];
              final statuses = ['READY', 'REMITTED', 'REMITTED', 'REMITTED', 'REMITTED', 'REMITTED', 'REMITTED', 'REMITTED'];
              return TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(periods[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('2200 - GST/HST Payable', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${collected[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${paidItc[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${(collected[idx]-paidItc[idx]).toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: presentationPaletteFixture2(context,
                      statuses[idx],
                      statuses[idx] == 'READY' ? 'warning' : 'success',
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PrimeElevatedButton.icon(
              icon: const PrimeIcon(LucideIcons.fileText),
              label: const PrimeText('Export CRA Remittance Form (GST34)'),
              onPressed: () {},
            ),
            const SizedBox(width: 12),
            PrimeElevatedButton(
              style: PrimeElevatedButton.styleFrom(backgroundColor: PrimeSemanticPalette.of(context, PrimeSemanticTone.primary).accent),
              onPressed: () {},
              child: PrimeText('Execute CRA Bank Transfer Payout', style: TextStyle(color: PrimeSemanticPalette.of(context, PrimeSemanticTone.primary).onAccent)),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget presentationPaletteFixture14(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      presentationPaletteFixture3(context, [
        {'label': 'EBITDA Margin', 'value': '24.2%', 'trend': 'up', 'change': '+1.8% YoY Improvement'},
        {'label': 'Net Profit Yield', 'value': '\$312,500', 'trend': 'up', 'change': 'Consolidated operations Q2'},
        {'label': 'Branch Profit Goal', 'value': '12/12 Met', 'trend': 'up', 'change': 'All branches positive yield'},
        {'label': 'Return on Assets (ROA)', 'value': '14.5%', 'trend': 'up', 'change': '+0.8% asset valuation'},
      ]),
      presentationPaletteFixture4(context,
        title: 'Corporate Franchise Profitability Matrix',
        child: Table(
          border: TableBorder.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerLow),
              children: [
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Franchise Branch', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Total Inflow Revenue', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Total Outflow Expense', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Net Branch Yield', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Profit Margin %', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Status Badge', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
            ...List.generate(8, (idx) {
              final branches = [
                'Toronto Core HQ',
                'Vancouver Kitsilano',
                'Montreal Westmount',
                'Calgary Beltline',
                'Ottawa Glebe',
                'Edmonton Oliver',
                'Quebec City St-Roch',
                'Winnipeg Exchange'
              ];
              final revenues = [124500.0, 89000.0, 78500.0, 68000.0, 64200.0, 58000.0, 52000.0, 48500.0];
              final expenses = [84200.0, 61000.0, 54000.0, 49000.0, 45000.0, 42000.0, 38500.0, 36000.0];
              return TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(branches[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${revenues[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${expenses[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${(revenues[idx]-expenses[idx]).toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('${((revenues[idx]-expenses[idx])/revenues[idx]*100).toStringAsFixed(1)}%', style: const TextStyle(fontSize: 11))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: presentationPaletteFixture2(context, 'OPTIMAL', 'success'),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    ],
  );
}

Widget presentationPaletteFixture15(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      presentationPaletteFixture3(context, [
        {'label': 'Starting Cash Balance', 'value': '\$1,124,500', 'trend': 'up', 'change': 'As of June 01, 2026'},
        {'label': 'Cash Inflows (Reconciled)', 'value': '\$320,000', 'trend': 'up', 'change': 'Sales & client copays'},
        {'label': 'Cash Outflows (Paid)', 'value': '\$195,000', 'trend': 'down', 'change': 'Payroll & supplier payments'},
        {'label': 'Net Position End Period', 'value': '\$1,249,500', 'trend': 'up', 'change': 'Net Increase: +\$125,000'},
      ]),
      presentationPaletteFixture4(context,
        title: '30-Day Automated Cash Flow Projections',
        child: presentationPaletteFixture5(context, [70, 75, 80, 88, 92, 98], ['06-05', '06-10', '06-15', '06-20', '06-25', '06-30'], PrimeSemanticPalette.of(context, PrimeSemanticTone.primary).accent),
      ),
      presentationPaletteFixture4(context,
        title: 'Cashflow Projections Registry',
        child: Table(
          border: TableBorder.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerLow),
              children: [
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Forecast Target Date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Projection Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Expected Inflow', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Expected Outflow', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Net Reserve Buffer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
            ...List.generate(8, (idx) {
              final dates = ['June 30', 'July 05', 'July 10', 'July 15', 'July 20', 'July 25', 'July 30', 'August 05'];
              final types = ['Payroll Week', 'Billing Cycle', 'Standard Week', 'Payroll Week', 'Billing Cycle', 'Standard Week', 'Payroll Week', 'Billing Cycle'];
              final inflows = [42500.0, 112500.0, 15000.0, 48000.0, 98000.0, 24000.0, 45000.0, 120000.0];
              final outflows = [124500.0, 15000.0, 12000.0, 124500.0, 18000.0, 10000.0, 124500.0, 22000.0];
              return TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(dates[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(types[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${inflows[idx].toStringAsFixed(2)}', style: TextStyle(fontSize: 11, color: PrimeSemanticPalette.of(context, PrimeSemanticTone.success).onBase))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${outflows[idx].toStringAsFixed(2)}', style: TextStyle(fontSize: 11, color: PrimeSemanticPalette.of(context, PrimeSemanticTone.error).onBase))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${(inflows[idx]-outflows[idx]).toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                ],
              );
            }),
          ],
        ),
      ),
    ],
  );
}

Widget presentationPaletteFixture16(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      presentationPaletteFixture3(context, [
        {'label': 'Consolidated Cash Reserves', 'value': '\$1,245,000', 'trend': 'up', 'change': '+12.4% vs last period'},
        {'label': 'YTD Net Revenue', 'value': '\$1,842,500', 'trend': 'up', 'change': 'Operational growth metrics'},
        {'label': 'Working Capital', 'value': '\$922,000', 'trend': 'up', 'change': 'Consolidated balance sheet'},
        {'label': 'Profit Margin', 'value': '28.4%', 'trend': 'up', 'change': 'EBITDA target: 25.0%'},
      ]),
      Row(
        children: [
          Expanded(
            child: presentationPaletteFixture4(context,
              title: 'Revenue Streams Composition',
              child: presentationPaletteFixture5(context, [80, 45, 30, 20, 15, 10], ['Insurance', 'Franchise Fee', 'Co-Pay', 'Gov Payout', 'Private Direct', 'Other'], PrimeSemanticPalette.of(context, PrimeSemanticTone.primary).accent),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: presentationPaletteFixture4(context,
              title: 'Corporate Outflows Profile',
              child: presentationPaletteFixture5(context, [68, 12, 8, 5, 4, 3], ['Wages', 'Supplies', 'Rent', 'Travel', 'IT Software', 'Other'], PrimeSemanticPalette.of(context, PrimeSemanticTone.secondary).accent),
            ),
          ),
        ],
      ),
      presentationPaletteFixture4(context,
        title: 'Secure Ledger Reconciliation Status',
        child: Table(
          border: TableBorder.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerLow),
              children: [
                Padding(padding: EdgeInsets.all(10), child: PrimeText('GL Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Account Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Ledger Balance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Bank Balance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Reconciliation status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
            ...List.generate(8, (idx) {
              final accounts = ['1010', '1200', '2200', '5010', '5020', '5040', '4010', '1020'];
              final names = [
                'Cash Operations checking',
                'Accounts Receivable clearing',
                'GST/HST Remittance Payable',
                'Clinical Wages & salaries expense',
                'Corporate HQ Rent Lease',
                'Medical & sanitization Supplies',
                'Royalty Inflow Revenue account',
                'Cash Reserves savings bank'
              ];
              final ledgerBals = [1245000.0, 114800.0, 51210.0, 124500.0, 4200.0, 12400.0, 142000.0, 500000.0];
              final bankBals = [1245000.0, 114800.0, 51210.0, 124500.0, 4200.0, 14200.0, 142000.0, 500000.0];
              return TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(accounts[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(names[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${ledgerBals[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${bankBals[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: presentationPaletteFixture2(context,
                      ledgerBals[idx] == bankBals[idx] ? 'RECONCILED' : 'DISCREPANCY',
                      ledgerBals[idx] == bankBals[idx] ? 'success' : 'warning',
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    ],
  );
}

Widget presentationPaletteFixture17(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      presentationPaletteFixture3(context, [
        {'label': 'Total Accounts Payable', 'value': '\$12,400', 'trend': 'down', 'change': 'Sanitization supplies bulk'},
        {'label': 'Vendor Payouts Pending', 'value': '3 Invoices', 'trend': 'down', 'change': 'Awaiting CFO sign-off'},
        {'label': 'Corporate Rent Lease', 'value': '\$4,200', 'trend': 'up', 'change': 'Payment scheduled June 30'},
        {'label': 'Plaid Ledger Sync', 'value': 'Balanced', 'trend': 'up', 'change': 'Zero discrepancy flags'},
      ]),
      presentationPaletteFixture4(context,
        title: 'Supplier & Vendor Accounts Payable Ledger',
        child: Table(
          border: TableBorder.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
          columnWidths: const {
            0: FlexColumnWidth(1.0),
            1: FlexColumnWidth(2.0),
            2: FlexColumnWidth(1.2),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(1.2),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerLow),
              children: [
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Tx ID', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Vendor Payable Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Account code', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Voucher Balance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Payment status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
            ...List.generate(8, (idx) {
              final descriptions = [
                'Bulk sanitization supplies invoice Q2',
                'Telus Health Portal portal subscription',
                'Clinical team travel mileage reimbursement',
                'HQ Office Rent corporate property lease',
                'Medical inventory supply intake voucher',
                'Executive consultant advisory retainer fee',
                'CRA Tax Filing audit preparation fee',
                'Plaid API License annual renewal cost'
              ];
              final accounts = [
                '5040 - Medical Supplies',
                '5050 - IT & Software license',
                '5030 - Travel & Transport',
                '5020 - Corporate Rent',
                '5040 - Medical Supplies',
                '5080 - Professional Fees',
                '5080 - Professional Fees',
                '5050 - IT & Software license'
              ];
              final amounts = [12400.0, 480.0, 8240.0, 4200.0, 6800.0, 3500.0, 1500.0, 120.0];
              final statuses = ['PENDING_BANK', 'VERIFIED', 'VERIFIED', 'COMPLETED', 'VERIFIED', 'COMPLETED', 'COMPLETED', 'DISCREPANCY'];
              return TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('AP-2026-00${idx+1}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(descriptions[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(accounts[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${amounts[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: presentationPaletteFixture2(context,
                      statuses[idx],
                      statuses[idx] == 'COMPLETED' || statuses[idx] == 'VERIFIED' ? 'success' : 'warning',
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    ],
  );
}

Widget presentationPaletteFixture18(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      presentationPaletteFixture3(context, [
        {'label': 'Receivables Outstanding', 'value': '\$114,800', 'trend': 'up', 'change': 'Billing claims clearing'},
        {'label': 'Collection Efficiency', 'value': '98.4%', 'trend': 'up', 'change': '96% collection target'},
        {'label': 'Overdue Payments', 'value': '\$4,890', 'trend': 'down', 'change': 'CFO collections warning sent'},
        {'label': 'Plaid Ledger Inflows', 'value': 'Verified', 'trend': 'up', 'change': 'Double-entry books sync'},
      ]),
      presentationPaletteFixture4(context,
        title: 'Outstanding Client Claims & Receivables Aging Schedule',
        child: Table(
          border: TableBorder.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
          columnWidths: const {
            0: FlexColumnWidth(1.0),
            1: FlexColumnWidth(2.0),
            2: FlexColumnWidth(1.2),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(1.2),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerLow),
              children: [
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Invoice Ref', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Client Account Detail', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('GL Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Claim Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Aging Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
            ...List.generate(8, (idx) {
              final details = [
                'Sun Life Financial Claims Batch #1092',
                'John Smith (Lower Back Therapy)',
                'Amara Okafor (Physio Intake Session)',
                'Green Shield Medical Claims Clearing #45',
                'Carlos Santana (Palliative Care)',
                'Elena Rostova (Home Care Package)',
                'David Kim (Rehab Sessions Q2)',
                'Winnipeg West Regional Care Board'
              ];
              final amounts = [42500.0, 245.0, 185.0, 18240.0, 1420.0, 3200.0, 480.0, 24500.0];
              final statuses = ['PAID', 'UNPAID', 'PAID', 'PENDING', 'PAID', 'PAID', 'OVERDUE', 'PAID'];
              return TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('AR-2026-0${idx+100}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(details[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('1200 - Accounts Receivable', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${amounts[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: presentationPaletteFixture2(context,
                      statuses[idx],
                      statuses[idx] == 'PAID' ? 'success' : (statuses[idx] == 'PENDING' ? 'info' : 'danger'),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    ],
  );
}

Widget presentationPaletteFixture19(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      presentationPaletteFixture3(context, [
        {'label': 'Consolidated Cash Reserves', 'value': '\$1,245,000', 'trend': 'up', 'change': '+12.4% vs last period'},
        {'label': 'YTD Net Revenue', 'value': '\$1,842,500', 'trend': 'up', 'change': 'Operational growth metrics'},
        {'label': 'Working Capital', 'value': '\$922,000', 'trend': 'up', 'change': 'Consolidated balance sheet'},
        {'label': 'Profit Margin', 'value': '28.4%', 'trend': 'up', 'change': 'EBITDA target: 25.0%'},
      ]),
      Row(
        children: [
          Expanded(
            child: presentationPaletteFixture4(context,
              title: 'Revenue Streams Composition',
              child: presentationPaletteFixture5(context, [80, 45, 30, 20, 15, 10], ['Insurance', 'Franchise Fee', 'Co-Pay', 'Gov Payout', 'Private Direct', 'Other'], PrimeSemanticPalette.of(context, PrimeSemanticTone.primary).accent),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: presentationPaletteFixture4(context,
              title: 'Corporate Outflows Profile',
              child: presentationPaletteFixture5(context, [68, 12, 8, 5, 4, 3], ['Wages', 'Supplies', 'Rent', 'Travel', 'IT Software', 'Other'], PrimeSemanticPalette.of(context, PrimeSemanticTone.secondary).accent),
            ),
          ),
        ],
      ),
      presentationPaletteFixture4(context,
        title: 'Secure Ledger Reconciliation Status',
        child: Table(
          border: TableBorder.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerLow),
              children: [
                Padding(padding: EdgeInsets.all(10), child: PrimeText('GL Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Account Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Ledger Balance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Bank Balance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Reconciliation status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
            ...List.generate(8, (idx) {
              final accounts = ['1010', '1200', '2200', '5010', '5020', '5040', '4010', '1020'];
              final names = [
                'Cash Operations checking',
                'Accounts Receivable clearing',
                'GST/HST Remittance Payable',
                'Clinical Wages & salaries expense',
                'Corporate HQ Rent Lease',
                'Medical & sanitization Supplies',
                'Royalty Inflow Revenue account',
                'Cash Reserves savings bank'
              ];
              final ledgerBals = [1245000.0, 114800.0, 51210.0, 124500.0, 4200.0, 12400.0, 142000.0, 500000.0];
              final bankBals = [1245000.0, 114800.0, 51210.0, 124500.0, 4200.0, 14200.0, 142000.0, 500000.0];
              return TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(accounts[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(names[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${ledgerBals[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${bankBals[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: presentationPaletteFixture2(context,
                      ledgerBals[idx] == bankBals[idx] ? 'RECONCILED' : 'DISCREPANCY',
                      ledgerBals[idx] == bankBals[idx] ? 'success' : 'warning',
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    ],
  );
}

Widget presentationPaletteFixture20(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      presentationPaletteFixture3(context, [
        {'label': 'Consolidated Franchise Revenue', 'value': '\$512,400', 'trend': 'up', 'change': '+14.6% vs previous period'},
        {'label': 'Franchise Royalties Collected', 'value': '\$142,000', 'trend': 'up', 'change': '12 active franchise locations'},
        {'label': 'Consolidated Margins', 'value': '28.4%', 'trend': 'up', 'change': 'EBITDA Target 25.0%'},
        {'label': 'Underperforming Branches', 'value': '0 Locations', 'trend': 'down', 'change': 'All branches positive yield'},
      ]),
      presentationPaletteFixture4(context,
        title: 'Franchise Branch Financial Breakdown & Royalties',
        child: Table(
          border: TableBorder.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
          columnWidths: const {
            0: FlexColumnWidth(1.2),
            1: FlexColumnWidth(1.2),
            2: FlexColumnWidth(1.2),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(1.0),
            5: FlexColumnWidth(1.0),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerLow),
              children: [
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Franchise Branch', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Gross Revenue', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Operating Expense', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Royalty (7%)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('EBITDA Margin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
            ...List.generate(8, (idx) {
              final branches = [
                'Toronto Core HQ',
                'Vancouver Kitsilano',
                'Montreal Westmount',
                'Calgary Beltline',
                'Ottawa Glebe',
                'Edmonton Oliver',
                'Quebec City St-Roch',
                'Winnipeg Exchange'
              ];
              final revenues = [124500.0, 89000.0, 78500.0, 68000.0, 64200.0, 58000.0, 52000.0, 48500.0];
              final expenses = [84200.0, 61000.0, 54000.0, 49000.0, 45000.0, 42000.0, 38500.0, 36000.0];
              return TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(branches[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${revenues[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${expenses[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${(revenues[idx]*0.07).toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('${((revenues[idx]-expenses[idx])/revenues[idx]*100).toStringAsFixed(1)}%', style: const TextStyle(fontSize: 11))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: presentationPaletteFixture2(context, 'ACTIVE', 'success'),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    ],
  );
}

Widget presentationPaletteFixture21(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      presentationPaletteFixture3(context, [
        {'label': 'Reports Generated', 'value': '142 Reports', 'trend': 'up', 'change': 'Audit logs matched'},
        {'label': 'Pending Audits', 'value': '0 Flags', 'trend': 'down', 'change': 'All corporate books clean'},
        {'label': 'Last Export', 'value': 'Today 08:14', 'trend': 'up', 'change': 'CFO ledger reconciliation'},
        {'label': 'Compliance Standing', 'value': '100% Score', 'trend': 'up', 'change': 'CRA/Tax requirements met'},
      ]),
      presentationPaletteFixture4(context,
        title: 'Secure Financial Exports & Audits Hub',
        child: Table(
          border: TableBorder.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
          columnWidths: const {
            0: FlexColumnWidth(1.2),
            1: FlexColumnWidth(2.5),
            2: FlexColumnWidth(1.0),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(1.2),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerLow),
              children: [
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Report Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Report Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Format', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('File Size', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Filing Action', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
            ...List.generate(8, (idx) {
              final reports = [
                'GST/HST Quarterly Remittance Return',
                'Clinical Wages & Payroll Audit Log',
                'Accounts Payable Vendor Ledger Sheet',
                'Consolidated Corporate Profit & Loss',
                'Plaid Bank Sync Reconciliation Log',
                'Consolidated Balance Sheet Statement',
                'Franchise Branch Royalties Statement',
                '30-Day Cash Flow Projection Model'
              ];
              final descs = [
                'GST34 Filing sheet for CRA submission Q2',
                'Bi-weekly clinical wages expense audit summary',
                'Accounts payable voucher logs for auditors',
                'Quarterly P&L statement corporate level',
                'Automated ledger plaid bank reconciliation check',
                'Assets, liabilities, and owner equity overview',
                'Consolidated royalties collected across 12 branches',
                'Deterministic AI cash flow prediction curves'
              ];
              final formats = ['XLSX/PDF', 'PDF', 'CSV/XLSX', 'PDF', 'CSV', 'PDF', 'PDF', 'XLSX'];
              final sizes = ['2.4 MB', '4.8 MB', '1.2 MB', '5.6 MB', '820 KB', '3.1 MB', '1.8 MB', '1.1 MB'];
              return TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(reports[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(descs[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(formats[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(sizes[idx], style: const TextStyle(fontSize: 11))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: presentationPaletteFixture2(context, 'EXPORTED', 'success'),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    ],
  );
}

Widget presentationPaletteFixture22(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      presentationPaletteFixture3(context, [
        {'label': 'GST/HST Payable Q2', 'value': '\$51,210', 'trend': 'up', 'change': 'Net CRA remittance due'},
        {'label': 'Payroll Tax Pending', 'value': '\$24,500', 'trend': 'up', 'change': 'Source deductions sign-off'},
        {'label': 'Corporate Tax Estimate', 'value': '\$110,000', 'trend': 'up', 'change': 'Filing Period: Q2-2026'},
        {'label': 'Remitted Year-to-Date', 'value': '\$380,000', 'trend': 'up', 'change': '100% compliant filings'},
      ]),
      presentationPaletteFixture4(context,
        title: 'Government Tax Filing & Remittance Schedule',
        child: Table(
          border: TableBorder.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerLow),
              children: [
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Tax Liability Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Jurisdiction Agency', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Filing Period', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Amount Due', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Filing Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: PrimeText('Action Remit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
            ...List.generate(8, (idx) {
              final types = [
                'GST/HST Quarterly Remittance Return',
                'Payroll Source Deduction Remittance',
                'Corporate Income Tax Instalment Q2',
                'Employer Health Tax (EHT) Return',
                'WSIB Ontario Premium Remittance',
                'GST/HST Quarterly Remittance Return Q1',
                'Payroll Source Deduction Remittance May',
                'Corporate Income Tax Instalment Q1'
              ];
              final agencies = ['Canada Revenue Agency', 'Canada Revenue Agency', 'Canada Revenue Agency', 'Ontario Ministry of Finance', 'WSIB Ontario', 'Canada Revenue Agency', 'Canada Revenue Agency', 'Canada Revenue Agency'];
              final periods = ['Q2-2026', 'June-2026', 'Q2-2026', 'Annual-2026', 'Q2-2026', 'Q1-2026', 'May-2026', 'Q1-2026'];
              final amounts = [51210.0, 24500.0, 110000.0, 12400.0, 4800.0, 47800.0, 22400.0, 110000.0];
              final statuses = ['READY', 'READY', 'ESTIMATE', 'COMPUTED', 'READY', 'REMITTED', 'REMITTED', 'REMITTED'];
              return TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(types[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(agencies[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText(periods[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: PrimeText('\$${amounts[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: presentationPaletteFixture2(context,
                      statuses[idx],
                      statuses[idx] == 'REMITTED' ? 'success' : 'warning',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: PrimeText(
                      statuses[idx] == 'REMITTED' ? 'Archived' : 'Sign and Submit',
                      style: TextStyle(
                        fontSize: 10,
                        color: statuses[idx] == 'REMITTED' ? Theme.of(context).colorScheme.onSurfaceVariant : PrimeSemanticPalette.of(context, PrimeSemanticTone.primary).onBase,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    ],
  );
}
