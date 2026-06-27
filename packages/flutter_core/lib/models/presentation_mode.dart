import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Flag to enable high-fidelity screenshot presentation mode.
bool screenshotPresentationMode = false;

/// Builds the presentation screen with investor-grade SaaS visual style.
Widget buildPresentationScreen(BuildContext context, dynamic ref, String screenType) {
  // Normalize screenType to handle instances like "CfoDashboardScreen"
  final normalizedType = screenType.replaceAll('_', '').toLowerCase();
  
  // 1. Get Details based on screenType
  String title = 'Financial Ledger';
  String screenLabel = 'Ledger Overview';
  Widget bodyContent = const Center(child: Text('Dashboard under construction'));
  
  if (normalizedType.contains('cfodashboard')) {
    title = 'CFO Strategic Finance HUD';
    screenLabel = 'Financial Dashboard';
    bodyContent = buildCfoDashboardContent(context);
  } else if (normalizedType.contains('cfoanalytics')) {
    title = 'Financial Analytics & Forecasting';
    screenLabel = 'Analytics Hub';
    bodyContent = _buildCfoAnalyticsContent(context);
  } else if (normalizedType.contains('cfoworkflow')) {
    title = 'Automated Workflow Engine';
    screenLabel = 'Workflow Management';
    bodyContent = _buildCfoWorkflowContent(context);
  } else if (normalizedType.contains('cforevenue')) {
    title = 'Revenue Stream Inflows';
    screenLabel = 'Revenue Tracking';
    bodyContent = _buildCfoRevenueContent(context);
  } else if (normalizedType.contains('cfoexpenses')) {
    title = 'Corporate Expenses & Disbursals';
    screenLabel = 'Expense Logs';
    bodyContent = _buildCfoExpensesContent(context);
  } else if (normalizedType.contains('cfopayroll')) {
    title = 'Payroll Approval & Disbursement';
    screenLabel = 'Payroll Control Center';
    bodyContent = _buildCfoPayrollContent(context);
  } else if (normalizedType.contains('cfoinvoices')) {
    title = 'Client Invoice Management';
    screenLabel = 'Invoice Registry';
    bodyContent = _buildCfoInvoicesContent(context);
  } else if (normalizedType.contains('cfotax')) {
    title = 'Tax Compliance & HST Ledger';
    screenLabel = 'Tax Compliance';
    bodyContent = _buildCfoTaxContent(context);
  } else if (normalizedType.contains('cfoprofitability')) {
    title = 'Profitability & Margin HUD';
    screenLabel = 'Profitability metrics';
    bodyContent = _buildCfoProfitabilityContent(context);
  }
    // Additional CFO screens
    else if (normalizedType.contains('cfocashflow')) {
      title = 'Cash Flow Projection';
      screenLabel = 'Cash Flow Management';
      bodyContent = _buildCfoCashflowContent(context);
    } else if (normalizedType.contains('financialdashboard')) {
      title = 'Corporate Financial Overview';
      screenLabel = 'Financial Dashboard';
      bodyContent = _buildFinancialDashboardContent(context);
    } else if (normalizedType.contains('cfoaccountspayable')) {
      title = 'Accounts Payable Ledger';
      screenLabel = 'Accounts Payable';
      bodyContent = _buildCfoAccountsPayableContent(context);
    } else if (normalizedType.contains('cfoaccountsreceivable')) {
      title = 'Accounts Receivable Ledger';
      screenLabel = 'Accounts Receivable';
      bodyContent = _buildCfoAccountsReceivableContent(context);
    } else if (normalizedType.contains('cfofinancialoverview')) {
      title = 'Corporate Financial Overview';
      screenLabel = 'Financial Overview';
      bodyContent = _buildCfoFinancialOverviewContent(context);
    } else if (normalizedType.contains('cfofranchisefinancials')) {
      title = 'Franchise Financial Performance';
      screenLabel = 'Franchise Financials';
      bodyContent = _buildCfoFranchiseFinancialsContent(context);
    } else if (normalizedType.contains('cforeports')) {
      title = 'Financial Reports & Audits';
      screenLabel = 'Reports Hub';
      bodyContent = _buildCfoReportsContent(context);
    } else if (normalizedType.contains('cfotaxandremittance')) {
      title = 'Tax Remittance & Returns';
      screenLabel = 'Tax & Remittance';
      bodyContent = _buildCfoTaxAndRemittanceContent(context);
    } else if (normalizedType.contains('finance_director')) {
      title = 'Finance Director Dashboard';
      screenLabel = 'Finance Dashboard';
      bodyContent = buildCfoDashboardContent(context);
    } else {
      // Default fallback
      title = 'CFO Financial Interface';
      screenLabel = 'Finance Module';
      bodyContent = buildCfoDashboardContent(context);
    }
    // Determine role label for header
    String roleLabel;
    if (normalizedType.contains('finance_director')) {
      roleLabel = 'Finance Director';
    } else if (normalizedType.contains('cfo')) {
      roleLabel = 'CFO';
    } else {
      roleLabel = 'User';
    }

  // 2. Wrap screen in SaaS presentation wrapper
  return Scaffold(
    backgroundColor: const Color(0xFFF1F5F9), // Slate 100
    body: Column(
      children: [
        // PART 7 - AUTO SCREEN TITLE HEADER
        Container(
          width: double.infinity,
          height: 48,
          decoration: const BoxDecoration(
            color: Color(0xFF0F172A), // Slate 900
            border: Border(
              bottom: BorderSide(color: Color(0xFF334155), width: 1),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(LucideIcons.activity, color: Color(0xFF38BDF8), size: 18),
                  const SizedBox(width: 8),
                  const Text(
                    'PrimeCare Enterprise Platform',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 16,
                    width: 1,
                    color: const Color(0xFF475569),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Role: $roleLabel',
                    style: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Screen: $screenLabel',
                    style: const TextStyle(
                      color: Color(0xFF38BDF8),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0369A1), // Sky 700
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Demo Preview',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Main App Layout (Sidebar + Body)
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left Sidebar (Stripe-like)
              Container(
                width: 220,
                color: const Color(0xFF1E293B), // Slate 800
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand / Logo
                    Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 20),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(LucideIcons.shieldAlert, color: Colors.white, size: 16),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'PRIMECARE',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Sidebar Menu Items
                    _buildSidebarItem(LucideIcons.layoutDashboard, 'Dashboard', normalizedType.contains('cfodashboard')),
                    _buildSidebarItem(LucideIcons.barChart2, 'Analytics', normalizedType.contains('cfoanalytics')),
                    _buildSidebarItem(LucideIcons.gitPullRequest, 'Workflows', normalizedType.contains('cfoworkflow')),
                    _buildSidebarItem(LucideIcons.arrowUpRight, 'Revenue Streams', normalizedType.contains('cforevenue')),
                    _buildSidebarItem(LucideIcons.arrowDownLeft, 'Expenses Log', normalizedType.contains('cfoexpenses')),
                    _buildSidebarItem(LucideIcons.users, 'Payroll Run', normalizedType.contains('cfopayroll')),
                    _buildSidebarItem(LucideIcons.fileSpreadsheet, 'Invoice Control', normalizedType.contains('cfoinvoices')),
                    _buildSidebarItem(LucideIcons.calculator, 'Tax & Compliance', normalizedType.contains('cfotax') || normalizedType.contains('taxandremittance')),
                    _buildSidebarItem(LucideIcons.pieChart, 'Profitability', normalizedType.contains('cfoprofitability')),
                    _buildSidebarItem(LucideIcons.trendingUp, 'Cashflow Projections', normalizedType.contains('cfocashflow')),
                    _buildSidebarItem(LucideIcons.building, 'Franchise Financials', normalizedType.contains('cfofranchisefinancials')),
                    _buildSidebarItem(LucideIcons.files, 'Financial Reports', normalizedType.contains('cforeports')),
                    
                    const Spacer(),
                    
                    // User Profile at bottom of sidebar
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          _buildAvatar('Sarah Jenkins', 0),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Sarah Jenkins',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Chief Financial Officer',
                                  style: TextStyle(
                                    color: Color(0xFF64748B),
                                    fontSize: 9,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Main Screen Body
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: bodyContent,
                      ),
                    ),
                    
                    // PART 6 - WATERMARK
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xCC0F172A), // Slate 900 with opacity
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0x33FFFFFF)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(LucideIcons.shieldCheck, color: Color(0xFF38BDF8), size: 12),
                            SizedBox(width: 6),
                            Text(
                              'PrimeCare Demo Preview',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSidebarItem(IconData icon, String text, bool isActive) {
  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF0284C7) : Colors.transparent, // Sky 600
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isActive ? Colors.white : const Color(0xFF94A3B8),
                  size: 16,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isActive ? Colors.white : const Color(0xFFCBD5E1),
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

// ----------------------------------------------------
// UI Enhancement Helpers & Beautiful Mock Components
// ----------------------------------------------------

Widget _buildAvatar(String name, int index) {
  final colors = [
    const Color(0xFFEF4444), // Red
    const Color(0xFFF97316), // Orange
    const Color(0xFFF59E0B), // Yellow
    const Color(0xFF10B981), // Green
    const Color(0xFF06B6D4), // Cyan
    const Color(0xFF3B82F6), // Blue
    const Color(0xFF8B5CF6), // Purple
    const Color(0xFFEC4899), // Pink
  ];
  final initials = name.split(' ').map((e) => e[0]).take(2).join('').toUpperCase();
  return Container(
    width: 24,
    height: 24,
    decoration: BoxDecoration(
      color: colors[index % colors.length].withOpacity(0.2),
      shape: BoxShape.circle,
      border: Border.all(color: colors[index % colors.length], width: 1.5),
    ),
    alignment: Alignment.center,
    child: Text(
      initials,
      style: TextStyle(
        color: colors[index % colors.length],
        fontWeight: FontWeight.bold,
        fontSize: 10,
      ),
    ),
  );
}

Widget _buildBadge(String text, String type) {
  Color bg = const Color(0xFFF1F5F9);
  Color fg = const Color(0xFF475569);
  
  if (type == 'success') {
    bg = const Color(0xFFDCFCE7);
    fg = const Color(0xFF166534);
  } else if (type == 'warning') {
    bg = const Color(0xFFFEF3C7);
    fg = const Color(0xFF92400E);
  } else if (type == 'danger') {
    bg = const Color(0xFFFEE2E2);
    fg = const Color(0xFF991B1B);
  } else if (type == 'info') {
    bg = const Color(0xFFE0F2FE);
    fg = const Color(0xFF0369A1);
  }
  
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: fg,
        fontSize: 10,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget _buildKpiRow(List<Map<String, String>> cards) {
  return Row(
    children: cards.map((c) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                c['label']!,
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                c['value']!,
                style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    c['trend'] == 'up' ? LucideIcons.trendingUp : LucideIcons.trendingDown,
                    color: c['trend'] == 'up' ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
                    size: 12,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      c['change']!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: c['trend'] == 'up' ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
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

Widget _buildSectionCard({required String title, required Widget child}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFE2E8F0)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.02),
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
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF0F172A),
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

Widget _buildCustomChart(List<double> values, List<String> labels, Color color) {
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
              Text(
                labels[idx],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF64748B),
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

// ----------------------------------------------------
// 17 BEAUTIFUL CFO PRESENTATION CONTENTS
// ----------------------------------------------------

Widget buildCfoDashboardContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildKpiRow([
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
            child: _buildSectionCard(
              title: 'Monthly Cash Inflow and Invoices Status',
              child: _buildCustomChart([30, 45, 60, 55, 80, 95], ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'], const Color(0xFF0284C7)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSectionCard(
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
                        const Icon(LucideIcons.checkCircle2, color: Color(0xFF16A34A), size: 14),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            actions[idx],
                            style: const TextStyle(fontSize: 11, color: Color(0xFF475569)),
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
      _buildSectionCard(
        title: 'Action Queue — Pending High Priority Invoices & Reimbursements',
        child: Table(
          border: TableBorder.all(color: const Color(0xFFF1F5F9), width: 1),
          columnWidths: const {
            0: FlexColumnWidth(1.2),
            1: FlexColumnWidth(2.5),
            2: FlexColumnWidth(1.5),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(1.5),
          },
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFF8FAFC)),
              children: [
                Padding(padding: EdgeInsets.all(10), child: Text('Tx ID', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Debit Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
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
                  Padding(padding: const EdgeInsets.all(10), child: Text('TX-2026-00${idx+1}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(descriptions[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(accounts[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${amounts[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildBadge(
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

Widget _buildCfoAnalyticsContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildKpiRow([
        {'label': 'Operating Margin', 'value': '34.2%', 'trend': 'up', 'change': '+2.1% YoY growth'},
        {'label': 'Cost Reduction YTD', 'value': '-\$45,800', 'trend': 'up', 'change': 'Medical supplier renegotiations'},
        {'label': 'Forecast Accuracy', 'value': '98.4%', 'trend': 'up', 'change': 'AI Cash Flow projections'},
        {'label': 'Branch Discrepancies', 'value': '0', 'trend': 'down', 'change': 'All ledgers verified'},
      ]),
      Row(
        children: [
          Expanded(
            child: _buildSectionCard(
              title: 'Consolidated Expense Forecast vs Actual',
              child: _buildCustomChart([50, 60, 48, 72, 85, 90], ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'], const Color(0xFFEF4444)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSectionCard(
              title: 'Revenue Projection 12-Month Outlook',
              child: _buildCustomChart([80, 85, 95, 110, 120, 135], ['Q1', 'Q2', 'Q3', 'Q4', 'Q1-27', 'Q2-27'], const Color(0xFF10B981)),
            ),
          ),
        ],
      ),
      _buildSectionCard(
        title: 'Detailed KPI Performance Matrix',
        child: Table(
          border: TableBorder.all(color: const Color(0xFFF1F5F9), width: 1),
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFF8FAFC)),
              children: [
                Padding(padding: EdgeInsets.all(10), child: Text('Indicator KPI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Target Value', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Current Value', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
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
                  Padding(padding: const EdgeInsets.all(10), child: Text(indicators[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(targets[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(currents[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildBadge('OPTIMAL', 'success'),
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

Widget _buildCfoWorkflowContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildKpiRow([
        {'label': 'Pending Approvals', 'value': '12 Invoices', 'trend': 'down', 'change': '-4 processed in last 2h'},
        {'label': 'Average SLA Time', 'value': '4.2 Hours', 'trend': 'up', 'change': '99.8% compliance level'},
        {'label': 'Triggered Audits', 'value': '0 Alerts', 'trend': 'down', 'change': 'Secure ledger validation'},
        {'label': 'Rejected Claims', 'value': '2 Batches', 'trend': 'up', 'change': 'Returned to billing admin'},
      ]),
      _buildSectionCard(
        title: 'Active CFO Approval & Reconciliation Workflows',
        child: Table(
          border: TableBorder.all(color: const Color(0xFFF1F5F9), width: 1),
          columnWidths: const {
            0: FlexColumnWidth(1.2),
            1: FlexColumnWidth(2.5),
            2: FlexColumnWidth(1.5),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(1.2),
          },
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFF8FAFC)),
              children: [
                Padding(padding: EdgeInsets.all(10), child: Text('Workflow ID', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Process Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Initiator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Priority', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Workflow State', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
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
                  Padding(padding: const EdgeInsets.all(10), child: Text('WF-2026-90${idx+1}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(workflowNames[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(initiators[idx], style: const TextStyle(fontSize: 11))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildBadge(
                      priorities[idx],
                      priorities[idx] == 'URGENT' ? 'danger' : (priorities[idx] == 'HIGH' ? 'warning' : 'info'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildBadge(
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

Widget _buildCfoRevenueContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildKpiRow([
        {'label': 'Gross Inflows YTD', 'value': '\$1,842,500', 'trend': 'up', 'change': '+14.6% year-over-year'},
        {'label': 'Client Copayments', 'value': '\$84,250', 'trend': 'up', 'change': '96% collection efficiency'},
        {'label': 'Royalty Revenue', 'value': '\$120,400', 'trend': 'up', 'change': '12 active branches'},
        {'label': 'Outstanding Invoices', 'value': '\$28,490', 'trend': 'down', 'change': '30-day collection cycle'},
      ]),
      _buildSectionCard(
        title: 'Monthly Cash Inflow Streams (Consolidated)',
        child: _buildCustomChart([85, 98, 120, 115, 142, 184], ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'], const Color(0xFF10B981)),
      ),
      _buildSectionCard(
        title: 'Revenue Sources Detail Logs',
        child: Table(
          border: TableBorder.all(color: const Color(0xFFF1F5F9), width: 1),
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFF8FAFC)),
              children: [
                Padding(padding: EdgeInsets.all(10), child: Text('Transaction Ref', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Source Origin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Plaid Account Match', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Amount Recd', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Ledger Sync', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
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
                  Padding(padding: const EdgeInsets.all(10), child: Text('REV-2026-00${idx+1}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(origins[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(accounts[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${amounts[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildBadge('BALANCED', 'success'),
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

Widget _buildCfoExpensesContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildKpiRow([
        {'label': 'Total Expenses YTD', 'value': '\$542,800', 'trend': 'up', 'change': 'Within +/- 2% budget margins'},
        {'label': 'Supplier Liabilities', 'value': '\$12,400', 'trend': 'down', 'change': 'Bulk discount negotiated'},
        {'label': 'Wages & Salaries', 'value': '\$184,250', 'trend': 'up', 'change': 'All Allied Health payroll run'},
        {'label': 'Discrepancy Alerts', 'value': '1 Flag', 'trend': 'up', 'change': 'Plaid Ledger sync audit notice'},
      ]),
      _buildSectionCard(
        title: 'Monthly Cash Outflow Expenses',
        child: _buildCustomChart([52, 60, 58, 48, 62, 74], ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'], const Color(0xFFEF4444)),
      ),
      _buildSectionCard(
        title: 'Corporate Outflow Expenses Ledger',
        child: Table(
          border: TableBorder.all(color: const Color(0xFFF1F5F9), width: 1),
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFF8FAFC)),
              children: [
                Padding(padding: EdgeInsets.all(10), child: Text('Voucher ID', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Vendor Category', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Ledger Offset', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Amount Paid', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Remit Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
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
                  Padding(padding: const EdgeInsets.all(10), child: Text('EXP-2026-80${idx+1}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(categories[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(offsets[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${amounts[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildBadge(
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

Widget _buildCfoPayrollContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildKpiRow([
        {'label': 'Active Employees', 'value': '245 Staff', 'trend': 'up', 'change': '+12 new hires this period'},
        {'label': 'Total Payroll Run', 'value': '\$124,500', 'trend': 'up', 'change': 'Bi-weekly billing cycle'},
        {'label': 'Pending Approvals', 'value': '27 Approvals', 'trend': 'down', 'change': 'Awaiting CFO authorization'},
        {'label': 'Average Hour Rate', 'value': '\$42.50/hr', 'trend': 'up', 'change': 'Standard Allied Health rate'},
      ]),
      _buildSectionCard(
        title: 'Clinical Allied Health Staff Payroll Registry (Active Period)',
        child: Table(
          border: TableBorder.all(color: const Color(0xFFF1F5F9), width: 1),
          columnWidths: const {
            0: FlexColumnWidth(0.5),
            1: FlexColumnWidth(1.8),
            2: FlexColumnWidth(1.5),
            3: FlexColumnWidth(0.8),
            4: FlexColumnWidth(1.2),
            5: FlexColumnWidth(1.2),
          },
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFF8FAFC)),
              children: [
                Padding(padding: EdgeInsets.all(10), child: Text('User', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Employee Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Branch Role', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Hours', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Gross Pay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Audit Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
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
                    child: Center(child: _buildAvatar(names[idx], idx)),
                  ),
                  Padding(padding: const EdgeInsets.all(10), child: Text(names[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(roles[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(hours[idx].toString(), style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${(hours[idx]*rates[idx]).toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildBadge(
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
            OutlinedButton(
              onPressed: () {},
              child: const Text('Export Payroll Audit Report'),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF16A34A)),
              onPressed: () {},
              child: const Text('Approve All Batches Sign-off', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildCfoInvoicesContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildKpiRow([
        {'label': 'Total Invoiced', 'value': '\$213,890', 'trend': 'up', 'change': '+8.2% vs previous period'},
        {'label': 'Collected Balance', 'value': '\$185,400', 'trend': 'up', 'change': 'Outstanding amount: \$28,490'},
        {'label': 'Pending Insurance', 'value': '\$18,240', 'trend': 'down', 'change': 'Awaiting clearing validation'},
        {'label': 'Overdue Accounts', 'value': '4 Clients', 'trend': 'down', 'change': 'Automatic collection notice active'},
      ]),
      _buildSectionCard(
        title: 'Receivables Invoice Control Hub',
        child: Table(
          border: TableBorder.all(color: const Color(0xFFF1F5F9), width: 1),
          columnWidths: const {
            0: FlexColumnWidth(1.0),
            1: FlexColumnWidth(2.0),
            2: FlexColumnWidth(1.2),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(1.2),
            5: FlexColumnWidth(1.2),
          },
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFF8FAFC)),
              children: [
                Padding(padding: EdgeInsets.all(10), child: Text('Invoice #', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Client Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Date Issued', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Amount Due', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Outstanding', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Filing Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
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
                  Padding(padding: const EdgeInsets.all(10), child: Text('INV-2026-0${idx+100}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(accounts[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(dates[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${amounts[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${outstanding[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildBadge(
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

Widget _buildCfoTaxContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildKpiRow([
        {'label': 'GST/HST Collected', 'value': '\$85,420', 'trend': 'up', 'change': 'Corporate Sales Revenue Q2'},
        {'label': 'Paid Input Tax Credits (ITC)', 'value': '\$34,210', 'trend': 'down', 'change': 'Supplier expenses offset'},
        {'label': 'Net CRA Remittance Due', 'value': '\$51,210', 'trend': 'up', 'change': 'Filing Period: Q2-2026'},
        {'label': 'Remittance Status', 'value': 'Ready', 'trend': 'up', 'change': 'Awaiting bank transfer sign-off'},
      ]),
      _buildSectionCard(
        title: 'GST/HST Compliance Posting Ledger',
        child: Table(
          border: TableBorder.all(color: const Color(0xFFF1F5F9), width: 1),
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFF8FAFC)),
              children: [
                Padding(padding: EdgeInsets.all(10), child: Text('Posting Period', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('CRA Account Ref', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Collected Tax', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Offset Credits', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Net Tax Due', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Remit Sign', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
            ...List.generate(8, (idx) {
              final periods = ['Q2-2026', 'Q1-2026', 'Q4-2025', 'Q3-2025', 'Q2-2025', 'Q1-2025', 'Q4-2024', 'Q3-2024'];
              final collected = [85420.0, 78900.0, 92100.0, 84200.0, 72500.0, 68000.0, 81000.0, 74200.0];
              final paidItc = [34210.0, 31000.0, 42000.0, 35000.0, 28000.0, 26000.0, 33000.0, 29000.0];
              final statuses = ['READY', 'REMITTED', 'REMITTED', 'REMITTED', 'REMITTED', 'REMITTED', 'REMITTED', 'REMITTED'];
              return TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(10), child: Text(periods[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('2200 - GST/HST Payable', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${collected[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${paidItc[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${(collected[idx]-paidItc[idx]).toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildBadge(
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
            ElevatedButton.icon(
              icon: const Icon(LucideIcons.fileText),
              label: const Text('Export CRA Remittance Form (GST34)'),
              onPressed: () {},
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0284C7)),
              onPressed: () {},
              child: const Text('Execute CRA Bank Transfer Payout', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildCfoProfitabilityContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildKpiRow([
        {'label': 'EBITDA Margin', 'value': '24.2%', 'trend': 'up', 'change': '+1.8% YoY Improvement'},
        {'label': 'Net Profit Yield', 'value': '\$312,500', 'trend': 'up', 'change': 'Consolidated operations Q2'},
        {'label': 'Branch Profit Goal', 'value': '12/12 Met', 'trend': 'up', 'change': 'All branches positive yield'},
        {'label': 'Return on Assets (ROA)', 'value': '14.5%', 'trend': 'up', 'change': '+0.8% asset valuation'},
      ]),
      _buildSectionCard(
        title: 'Corporate Franchise Profitability Matrix',
        child: Table(
          border: TableBorder.all(color: const Color(0xFFF1F5F9), width: 1),
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFF8FAFC)),
              children: [
                Padding(padding: EdgeInsets.all(10), child: Text('Franchise Branch', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Total Inflow Revenue', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Total Outflow Expense', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Net Branch Yield', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Profit Margin %', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Status Badge', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
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
                  Padding(padding: const EdgeInsets.all(10), child: Text(branches[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${revenues[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${expenses[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${(revenues[idx]-expenses[idx]).toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('${((revenues[idx]-expenses[idx])/revenues[idx]*100).toStringAsFixed(1)}%', style: const TextStyle(fontSize: 11))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildBadge('OPTIMAL', 'success'),
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

Widget _buildCfoCashflowContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildKpiRow([
        {'label': 'Starting Cash Balance', 'value': '\$1,124,500', 'trend': 'up', 'change': 'As of June 01, 2026'},
        {'label': 'Cash Inflows (Reconciled)', 'value': '\$320,000', 'trend': 'up', 'change': 'Sales & client copays'},
        {'label': 'Cash Outflows (Paid)', 'value': '\$195,000', 'trend': 'down', 'change': 'Payroll & supplier payments'},
        {'label': 'Net Position End Period', 'value': '\$1,249,500', 'trend': 'up', 'change': 'Net Increase: +\$125,000'},
      ]),
      _buildSectionCard(
        title: '30-Day Automated Cash Flow Projections',
        child: _buildCustomChart([70, 75, 80, 88, 92, 98], ['06-05', '06-10', '06-15', '06-20', '06-25', '06-30'], const Color(0xFF0284C7)),
      ),
      _buildSectionCard(
        title: 'Cashflow Projections Registry',
        child: Table(
          border: TableBorder.all(color: const Color(0xFFF1F5F9), width: 1),
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFF8FAFC)),
              children: [
                Padding(padding: EdgeInsets.all(10), child: Text('Forecast Target Date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Projection Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Expected Inflow', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Expected Outflow', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Net Reserve Buffer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
            ...List.generate(8, (idx) {
              final dates = ['June 30', 'July 05', 'July 10', 'July 15', 'July 20', 'July 25', 'July 30', 'August 05'];
              final types = ['Payroll Week', 'Billing Cycle', 'Standard Week', 'Payroll Week', 'Billing Cycle', 'Standard Week', 'Payroll Week', 'Billing Cycle'];
              final inflows = [42500.0, 112500.0, 15000.0, 48000.0, 98000.0, 24000.0, 45000.0, 120000.0];
              final outflows = [124500.0, 15000.0, 12000.0, 124500.0, 18000.0, 10000.0, 124500.0, 22000.0];
              return TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(10), child: Text(dates[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(types[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${inflows[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, color: Color(0xFF16A34A)))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${outflows[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, color: Color(0xFFDC2626)))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${(inflows[idx]-outflows[idx]).toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                ],
              );
            }),
          ],
        ),
      ),
    ],
  );
}

Widget _buildFinancialDashboardContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildKpiRow([
        {'label': 'Consolidated Cash Reserves', 'value': '\$1,245,000', 'trend': 'up', 'change': '+12.4% vs last period'},
        {'label': 'YTD Net Revenue', 'value': '\$1,842,500', 'trend': 'up', 'change': 'Operational growth metrics'},
        {'label': 'Working Capital', 'value': '\$922,000', 'trend': 'up', 'change': 'Consolidated balance sheet'},
        {'label': 'Profit Margin', 'value': '28.4%', 'trend': 'up', 'change': 'EBITDA target: 25.0%'},
      ]),
      Row(
        children: [
          Expanded(
            child: _buildSectionCard(
              title: 'Revenue Streams Composition',
              child: _buildCustomChart([80, 45, 30, 20, 15, 10], ['Insurance', 'Franchise Fee', 'Co-Pay', 'Gov Payout', 'Private Direct', 'Other'], const Color(0xFF0284C7)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSectionCard(
              title: 'Corporate Outflows Profile',
              child: _buildCustomChart([68, 12, 8, 5, 4, 3], ['Wages', 'Supplies', 'Rent', 'Travel', 'IT Software', 'Other'], const Color(0xFFEF4444)),
            ),
          ),
        ],
      ),
      _buildSectionCard(
        title: 'Secure Ledger Reconciliation Status',
        child: Table(
          border: TableBorder.all(color: const Color(0xFFF1F5F9), width: 1),
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFF8FAFC)),
              children: [
                Padding(padding: EdgeInsets.all(10), child: Text('GL Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Account Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Ledger Balance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Bank Balance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Reconciliation status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
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
                  Padding(padding: const EdgeInsets.all(10), child: Text(accounts[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(names[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${ledgerBals[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${bankBals[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildBadge(
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

Widget _buildCfoAccountsPayableContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildKpiRow([
        {'label': 'Total Accounts Payable', 'value': '\$12,400', 'trend': 'down', 'change': 'Sanitization supplies bulk'},
        {'label': 'Vendor Payouts Pending', 'value': '3 Invoices', 'trend': 'down', 'change': 'Awaiting CFO sign-off'},
        {'label': 'Corporate Rent Lease', 'value': '\$4,200', 'trend': 'up', 'change': 'Payment scheduled June 30'},
        {'label': 'Plaid Ledger Sync', 'value': 'Balanced', 'trend': 'up', 'change': 'Zero discrepancy flags'},
      ]),
      _buildSectionCard(
        title: 'Supplier & Vendor Accounts Payable Ledger',
        child: Table(
          border: TableBorder.all(color: const Color(0xFFF1F5F9), width: 1),
          columnWidths: const {
            0: FlexColumnWidth(1.0),
            1: FlexColumnWidth(2.0),
            2: FlexColumnWidth(1.2),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(1.2),
          },
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFF8FAFC)),
              children: [
                Padding(padding: EdgeInsets.all(10), child: Text('Tx ID', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Vendor Payable Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Account code', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Voucher Balance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Payment status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
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
                  Padding(padding: const EdgeInsets.all(10), child: Text('AP-2026-00${idx+1}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(descriptions[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(accounts[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${amounts[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildBadge(
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

Widget _buildCfoAccountsReceivableContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildKpiRow([
        {'label': 'Receivables Outstanding', 'value': '\$114,800', 'trend': 'up', 'change': 'Billing claims clearing'},
        {'label': 'Collection Efficiency', 'value': '98.4%', 'trend': 'up', 'change': '96% collection target'},
        {'label': 'Overdue Payments', 'value': '\$4,890', 'trend': 'down', 'change': 'CFO collections warning sent'},
        {'label': 'Plaid Ledger Inflows', 'value': 'Verified', 'trend': 'up', 'change': 'Double-entry books sync'},
      ]),
      _buildSectionCard(
        title: 'Outstanding Client Claims & Receivables Aging Schedule',
        child: Table(
          border: TableBorder.all(color: const Color(0xFFF1F5F9), width: 1),
          columnWidths: const {
            0: FlexColumnWidth(1.0),
            1: FlexColumnWidth(2.0),
            2: FlexColumnWidth(1.2),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(1.2),
          },
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFF8FAFC)),
              children: [
                Padding(padding: EdgeInsets.all(10), child: Text('Invoice Ref', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Client Account Detail', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('GL Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Claim Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Aging Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
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
                  Padding(padding: const EdgeInsets.all(10), child: Text('AR-2026-0${idx+100}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(details[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('1200 - Accounts Receivable', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${amounts[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildBadge(
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

Widget _buildCfoFinancialOverviewContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildKpiRow([
        {'label': 'Consolidated Cash Reserves', 'value': '\$1,245,000', 'trend': 'up', 'change': '+12.4% vs last period'},
        {'label': 'YTD Net Revenue', 'value': '\$1,842,500', 'trend': 'up', 'change': 'Operational growth metrics'},
        {'label': 'Working Capital', 'value': '\$922,000', 'trend': 'up', 'change': 'Consolidated balance sheet'},
        {'label': 'Profit Margin', 'value': '28.4%', 'trend': 'up', 'change': 'EBITDA target: 25.0%'},
      ]),
      Row(
        children: [
          Expanded(
            child: _buildSectionCard(
              title: 'Revenue Streams Composition',
              child: _buildCustomChart([80, 45, 30, 20, 15, 10], ['Insurance', 'Franchise Fee', 'Co-Pay', 'Gov Payout', 'Private Direct', 'Other'], const Color(0xFF0284C7)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSectionCard(
              title: 'Corporate Outflows Profile',
              child: _buildCustomChart([68, 12, 8, 5, 4, 3], ['Wages', 'Supplies', 'Rent', 'Travel', 'IT Software', 'Other'], const Color(0xFFEF4444)),
            ),
          ),
        ],
      ),
      _buildSectionCard(
        title: 'Secure Ledger Reconciliation Status',
        child: Table(
          border: TableBorder.all(color: const Color(0xFFF1F5F9), width: 1),
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFF8FAFC)),
              children: [
                Padding(padding: EdgeInsets.all(10), child: Text('GL Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Account Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Ledger Balance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Bank Balance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Reconciliation status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
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
                  Padding(padding: const EdgeInsets.all(10), child: Text(accounts[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(names[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${ledgerBals[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${bankBals[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildBadge(
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

Widget _buildCfoFranchiseFinancialsContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildKpiRow([
        {'label': 'Consolidated Franchise Revenue', 'value': '\$512,400', 'trend': 'up', 'change': '+14.6% vs previous period'},
        {'label': 'Franchise Royalties Collected', 'value': '\$142,000', 'trend': 'up', 'change': '12 active franchise locations'},
        {'label': 'Consolidated Margins', 'value': '28.4%', 'trend': 'up', 'change': 'EBITDA Target 25.0%'},
        {'label': 'Underperforming Branches', 'value': '0 Locations', 'trend': 'down', 'change': 'All branches positive yield'},
      ]),
      _buildSectionCard(
        title: 'Franchise Branch Financial Breakdown & Royalties',
        child: Table(
          border: TableBorder.all(color: const Color(0xFFF1F5F9), width: 1),
          columnWidths: const {
            0: FlexColumnWidth(1.2),
            1: FlexColumnWidth(1.2),
            2: FlexColumnWidth(1.2),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(1.0),
            5: FlexColumnWidth(1.0),
          },
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFF8FAFC)),
              children: [
                Padding(padding: EdgeInsets.all(10), child: Text('Franchise Branch', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Gross Revenue', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Operating Expense', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Royalty (7%)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('EBITDA Margin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
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
                  Padding(padding: const EdgeInsets.all(10), child: Text(branches[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${revenues[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${expenses[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${(revenues[idx]*0.07).toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('${((revenues[idx]-expenses[idx])/revenues[idx]*100).toStringAsFixed(1)}%', style: const TextStyle(fontSize: 11))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildBadge('ACTIVE', 'success'),
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

Widget _buildCfoReportsContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildKpiRow([
        {'label': 'Reports Generated', 'value': '142 Reports', 'trend': 'up', 'change': 'Audit logs matched'},
        {'label': 'Pending Audits', 'value': '0 Flags', 'trend': 'down', 'change': 'All corporate books clean'},
        {'label': 'Last Export', 'value': 'Today 08:14', 'trend': 'up', 'change': 'CFO ledger reconciliation'},
        {'label': 'Compliance Standing', 'value': '100% Score', 'trend': 'up', 'change': 'CRA/Tax requirements met'},
      ]),
      _buildSectionCard(
        title: 'Secure Financial Exports & Audits Hub',
        child: Table(
          border: TableBorder.all(color: const Color(0xFFF1F5F9), width: 1),
          columnWidths: const {
            0: FlexColumnWidth(1.2),
            1: FlexColumnWidth(2.5),
            2: FlexColumnWidth(1.0),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(1.2),
          },
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFF8FAFC)),
              children: [
                Padding(padding: EdgeInsets.all(10), child: Text('Report Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Report Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Format', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('File Size', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Filing Action', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
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
                  Padding(padding: const EdgeInsets.all(10), child: Text(reports[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(descs[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(formats[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(sizes[idx], style: const TextStyle(fontSize: 11))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildBadge('EXPORTED', 'success'),
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

Widget _buildCfoTaxAndRemittanceContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildKpiRow([
        {'label': 'GST/HST Payable Q2', 'value': '\$51,210', 'trend': 'up', 'change': 'Net CRA remittance due'},
        {'label': 'Payroll Tax Pending', 'value': '\$24,500', 'trend': 'up', 'change': 'Source deductions sign-off'},
        {'label': 'Corporate Tax Estimate', 'value': '\$110,000', 'trend': 'up', 'change': 'Filing Period: Q2-2026'},
        {'label': 'Remitted Year-to-Date', 'value': '\$380,000', 'trend': 'up', 'change': '100% compliant filings'},
      ]),
      _buildSectionCard(
        title: 'Government Tax Filing & Remittance Schedule',
        child: Table(
          border: TableBorder.all(color: const Color(0xFFF1F5F9), width: 1),
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFF8FAFC)),
              children: [
                Padding(padding: EdgeInsets.all(10), child: Text('Tax Liability Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Jurisdiction Agency', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Filing Period', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Amount Due', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Filing Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                Padding(padding: EdgeInsets.all(10), child: Text('Action Remit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
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
                  Padding(padding: const EdgeInsets.all(10), child: Text(types[idx], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(agencies[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text(periods[idx], style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(10), child: Text('\$${amounts[idx].toStringAsFixed(2)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildBadge(
                      statuses[idx],
                      statuses[idx] == 'REMITTED' ? 'success' : 'warning',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      statuses[idx] == 'REMITTED' ? 'Archived' : 'Sign and Submit',
                      style: TextStyle(
                        fontSize: 10,
                        color: statuses[idx] == 'REMITTED' ? const Color(0xFF64748B) : const Color(0xFF0284C7),
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
