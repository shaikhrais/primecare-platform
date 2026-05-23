// Governance - Category: view | Purpose: --- MVC State Model ---
import 'package:primecare_ui/primecare_ui.dart';


// --- MVC State Model ---
class ShareholderAnalyticsState {
  final List<Map<String, dynamic>> capTable;
  final double simulatedSharesCount;
  final double dividendPerShare;
  final double sharePriceValue;
  final bool isGeneratingReport;
  final bool showDownloadConfirmation;

  const ShareholderAnalyticsState({
    required this.capTable,
    required this.simulatedSharesCount,
    required this.dividendPerShare,
    required this.sharePriceValue,
    required this.isGeneratingReport,
    required this.showDownloadConfirmation,
  });

  ShareholderAnalyticsState copyWith({
    List<Map<String, dynamic>>? capTable,
    double? simulatedSharesCount,
    double? dividendPerShare,
    double? sharePriceValue,
    bool? isGeneratingReport,
    bool? showDownloadConfirmation,
  }) {
    return ShareholderAnalyticsState(
      capTable: capTable ?? this.capTable,
      simulatedSharesCount: simulatedSharesCount ?? this.simulatedSharesCount,
      dividendPerShare: dividendPerShare ?? this.dividendPerShare,
      sharePriceValue: sharePriceValue ?? this.sharePriceValue,
      isGeneratingReport: isGeneratingReport ?? this.isGeneratingReport,
      showDownloadConfirmation: showDownloadConfirmation ?? this.showDownloadConfirmation,
    );
  }
}

// --- Controller ---
class ShareholderAnalyticsController extends StateNotifier<ShareholderAnalyticsState> {
  final Ref _ref;

  ShareholderAnalyticsController(this._ref)
      : super(
          const ShareholderAnalyticsState(
            capTable: [
              {
                'shareholder': 'PrimeCare Founders Group',
                'shares': 1200000,
                'equity': '48.0%',
                'class': 'Class A Voting',
              },
              {
                'shareholder': 'Ontario Healthcare Venture Capital',
                'shares': 750000,
                'equity': '30.0%',
                'class': 'Class A Voting',
              },
              {
                'shareholder': 'Strategic Angel Investors syndicate',
                'shares': 350000,
                'equity': '14.0%',
                'class': 'Class B Preferred',
              },
              {
                'shareholder': 'Employee Stock Benefit Trust',
                'shares': 200000,
                'equity': '8.0%',
                'class': 'Class B Non-Voting',
              },
            ],
            simulatedSharesCount: 50000.0,
            dividendPerShare: 1.25,
            sharePriceValue: 24.50,
            isGeneratingReport: false,
            showDownloadConfirmation: false,
          ),
        );

  void updateSimulatedShares(double shares) {
    state = state.copyWith(simulatedSharesCount: shares);
  }

  void executeReportGeneration() {
    state = state.copyWith(isGeneratingReport: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/shareholder/analytics',
            eventType: 'shareholder_report_exported',
            metadata: {'simulatedShares': state.simulatedSharesCount},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 600), () {
      state = state.copyWith(
        isGeneratingReport: false,
        showDownloadConfirmation: true,
      );
    });
  }

  void dismissConfirmation() {
    state = state.copyWith(showDownloadConfirmation: false);
  }
}

// --- Provider ---
final shareholderAnalyticsControllerProvider =
    StateNotifierProvider<ShareholderAnalyticsController, ShareholderAnalyticsState>((ref) {
  return ShareholderAnalyticsController(ref);
});

// --- View ---
class ShareholderAnalyticsScreen extends GovernedConsumerWidget {
  const ShareholderAnalyticsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shareholderAnalyticsControllerProvider);
    final controller = ref.read(shareholderAnalyticsControllerProvider.notifier);
    final theme = context.theme;

    final portfolioValue = state.simulatedSharesCount * state.sharePriceValue;
    final projectedDividends = state.simulatedSharesCount * state.dividendPerShare;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.analytics_outlined, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Shareholder Analytics',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.showDownloadConfirmation)
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(theme.radiusMd),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_outline, color: Colors.green, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Quarterly earnings audit report generated and downloaded successfully!',
                        style: theme.typography.bodyMedium.copyWith(color: Colors.green.shade800),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 16, color: Colors.green),
                      onPressed: controller.dismissConfirmation,
                    ),
                  ],
                ),
              ),

            GovDashboardHero(
              title: 'Equity & Cap Table Analytics',
              roleName: 'Shareholder Portal',
              description: 'Centralized capital allocation, valuation multipliers, and dividend reconciliation.',
              onRefresh: () {},
            ),
            const SizedBox(height: 24),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Capitalization Table Section
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.colors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            'Corporate Capitalization Distribution (Cap Table)',
                            style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                          ),
                        ),
                        const Divider(height: 1),
                        // Table header
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          color: theme.colors.surface,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  'SHAREHOLDER ENTITY',
                                  style: theme.typography.labelBold.copyWith(color: theme.colors.onSurfaceVariant),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'SHARES',
                                  style: theme.typography.labelBold.copyWith(color: theme.colors.onSurfaceVariant),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'EQUITY %',
                                  style: theme.typography.labelBold.copyWith(color: theme.colors.onSurfaceVariant),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'SHARE CLASS',
                                  style: theme.typography.labelBold.copyWith(color: theme.colors.onSurfaceVariant),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                        // Table rows
                        ...state.capTable.map((holder) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: theme.colors.border)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    holder['shareholder'] as String,
                                    style: theme.typography.bodyLarge.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colors.onSurface,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    holder['shares'].toString().replaceAllMapped(
                                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match m) => '${m[1]},',
                                        ),
                                    style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    holder['equity'] as String,
                                    style: theme.typography.bodyMedium.copyWith(
                                      color: theme.colors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    holder['class'] as String,
                                    style: theme.typography.labelMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),

                // Shareholder calculator
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.colors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Yield & Payout Simulator',
                          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Adjust private shareholder stock size below to calculate dividend payouts.',
                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                        const SizedBox(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Share Holdings Count',
                              style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              state.simulatedSharesCount.toInt().toString().replaceAllMapped(
                                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                    (Match m) => '${m[1]},',
                                  ),
                              style: theme.typography.bodyLarge.copyWith(
                                color: theme.colors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: state.simulatedSharesCount,
                          min: 10000.0,
                          max: 250000.0,
                          divisions: 48,
                          activeColor: theme.colors.primary,
                          onChanged: controller.updateSimulatedShares,
                        ),
                        const SizedBox(height: 24),

                        // Yield breakdown metrics
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colors.background,
                            borderRadius: BorderRadius.circular(theme.radiusMd),
                            border: Border.all(color: theme.colors.border),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Simulated Holdings Valuation:',
                                    style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                  ),
                                  Text(
                                    '\$${portfolioValue.toStringAsFixed(2)}',
                                    style: theme.typography.bodyMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colors.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Projected Annual Dividends:',
                                    style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                  ),
                                  Text(
                                    '\$${projectedDividends.toStringAsFixed(2)}',
                                    style: theme.typography.h3.copyWith(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          child: state.isGeneratingReport
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton.icon(
                                  icon: const Icon(Icons.download_outlined),
                                  label: const Text('Export Earnings Audit Report'),
                                  onPressed: controller.executeReportGeneration,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colors.primary,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
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
    );
  }
}
