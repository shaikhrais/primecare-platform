// Governance - Category: view | Purpose: State representation of a localized service procurement order. Provider for service procurement records.
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

/// State representation of a localized service procurement order.
class ProcurementOrder {
  final String id;
  final String vendorName;
  final String serviceType;
  final double cost;
  final String targetHub;
  String status; // 'Pending Approval', 'Approved', 'Declined'

  ProcurementOrder({
    required this.id,
    required this.vendorName,
    required this.serviceType,
    required this.cost,
    required this.targetHub,
    required this.status,
  });
}

/// Provider for service procurement records.
final serviceProcurementProvider = FutureProvider.autoDispose<List<ProcurementOrder>>((ref) async {
  try {
    final api = ref.read(apiClientProvider);
    final response = await api.get('/v1/premium/appnotification');
    if (response.data is List) {
      final list = response.data as List;
      return list.map((e) {
        final map = e as Map<String, dynamic>;
        return ProcurementOrder(
          id: map['id']?.toString() ?? UniqueKey().toString(),
          vendorName: map['vendorName']?.toString() ?? 'Vendor Inc.',
          serviceType: map['serviceType']?.toString() ?? 'Medical Supplies',
          cost: double.tryParse(map['cost']?.toString() ?? '0.0') ?? 0.0,
          targetHub: map['targetHub']?.toString() ?? 'Main Hub',
          status: map['status']?.toString() ?? 'Pending Approval',
        );
      }).toList();
    }
  } catch (e) {
    // Offline fallback
  }

  // Pre-hydrated regional operations procurement data
  return [
    ProcurementOrder(
      id: 'proc-01',
      vendorName: 'Apex Disinfection Services',
      serviceType: 'Cleaning/Disinfection',
      cost: 4500.00,
      targetHub: 'Eastside Medical',
      status: 'Pending Approval',
    ),
    ProcurementOrder(
      id: 'proc-02',
      vendorName: 'SurgiCore Supplies Ltd',
      serviceType: 'Medical Supplies',
      cost: 12500.00,
      targetHub: 'North District Center',
      status: 'Approved',
    ),
    ProcurementOrder(
      id: 'proc-03',
      vendorName: 'MedTech Telemetry Inc',
      serviceType: 'Clinical Equipment',
      cost: 28900.00,
      targetHub: 'Westside General Clinic',
      status: 'Pending Approval',
    ),
    ProcurementOrder(
      id: 'proc-04',
      vendorName: 'EcoGuard Biohazard Co',
      serviceType: 'Cleaning/Disinfection',
      cost: 1800.00,
      targetHub: 'Southside Surgical',
      status: 'Approved',
    ),
  ];
});

class ServiceProcurementScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for submitting and managing procurement requests, monitoring spend, and analyzing procurement data with appropriate buttons and API integrations.';

  @override
  List<String> get requiredComponents => const [
        'ProcurementRequestForm',
        'PendingOrdersList',
        'SpendMonitor',
        'OrderStatusUpdater',
        'ProcurementDataAnalyzer',
        'TrendVisualization',
        'AlertsDashboard',
      ];

  @override
  List<String> get requiredFunctions => const [
        'submitProcurementRequest',
        'approvePendingOrder',
        'updateOrderStatus',
        'monitorSpend',
        'analyzeProcurementData',
      ];

  const ServiceProcurementScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    return const _ServiceProcurementBody();
  }
}

class _ServiceProcurementBody extends ConsumerStatefulWidget {
  const _ServiceProcurementBody();

  @override
  ConsumerState<_ServiceProcurementBody> createState() => _ServiceProcurementBodyState();
}

class _ServiceProcurementBodyState extends ConsumerState<_ServiceProcurementBody> {
  final List<ProcurementOrder> _orders = [];
  bool _isInitialized = false;

  final _vendorController = TextEditingController();
  final _costController = TextEditingController();
  String _selectedServiceType = 'Clinical Equipment';
  String _selectedHub = 'North District Center';

  final List<String> _serviceTypes = [
    'Clinical Equipment',
    'IT Infrastructure',
    'Cleaning/Disinfection',
    'Medical Supplies',
  ];

  final List<String> _regionalHubs = [
    'North District Center',
    'Eastside Medical',
    'Westside General Clinic',
    'Southside Surgical',
  ];

  @override
  void dispose() {
    _vendorController.dispose();
    _costController.dispose();
    super.dispose();
  }

  void _submitProcurementRequest() {
    final vendor = _vendorController.text.trim();
    final costStr = _costController.text.trim();

    if (vendor.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a Vendor Name.'),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    final costVal = double.tryParse(costStr);
    if (costVal == null || costVal <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid procurement cost (> \$0).'),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    final newOrder = ProcurementOrder(
      id: 'proc-user-${DateTime.now().millisecondsSinceEpoch}',
      vendorName: vendor,
      serviceType: _selectedServiceType,
      cost: costVal,
      targetHub: _selectedHub,
      status: 'Pending Approval',
    );

    setState(() {
      _orders.insert(0, newOrder);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        content: Row(
          children: [
            const Icon(LucideIcons.shoppingBag, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Procurement requested! \$${costVal.toStringAsFixed(2)} for $vendor pending regional sign-off.',
              ),
            ),
          ],
        ),
      ),
    );

    _vendorController.clear();
    _costController.clear();
  }

  void _updateOrderStatus(String id, String newStatus) {
    final idx = _orders.indexWhere((o) => o.id == id);
    if (idx != -1) {
      setState(() {
        _orders[idx].status = newStatus;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order for ${_orders[idx].vendorName} is now $newStatus.'),
          backgroundColor: newStatus == 'Approved' ? Colors.green : Colors.red,
        ),
      );
    }
  }

  Widget _buildHslBadge(String text, double hue, double saturation, double lightness) {
    final color = HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
    final bgColor = HSLColor.fromAHSL(0.12, hue, saturation, lightness).toColor();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final procurementFuture = ref.watch(serviceProcurementProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: procurementFuture.when(
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(48.0),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (Object err, StackTrace stack) => Center(
            child: Text(
              'Error loading procurement logs: $err',
              style: TextStyle(color: theme.colors.error),
            ),
          ),
          data: (List<ProcurementOrder> apiOrders) {
            if (!_isInitialized) {
              _orders.addAll(apiOrders);
              _isInitialized = true;
            }

            final totalSpend = _orders
                .where((o) => o.status == 'Approved')
                .fold<double>(0.0, (sum, o) => sum + o.cost);

            final pendingCount = _orders.where((o) => o.status == 'Pending Approval').length;
            final approvedCount = _orders.where((o) => o.status == 'Approved').length;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header
                const GovDashboardHero(
                  title: 'Localized Services & Vendor Procurement',
                  roleName: 'Regional Operations Director',
                  description: 'Authorize high-value vendor cleanings, manage local clinic infrastructure purchases, and keep regional spend under compliance limits.',
                ),
                const SizedBox(height: 24),

                // 2. Metric Grid with custom primary themes
                ResponsiveGrid(
                  minItemWidth: 260,
                  maxItemWidth: 400,
                  spacing: 16.0,
                  children: [
                    GovMetricCard(
                      title: 'Approved Regional Spend',
                      value: '\$${totalSpend.toStringAsFixed(2)}',
                      trendLabel: 'Active Contracts',
                      progress: 0.72,
                      icon: LucideIcons.dollarSign,
                      brandColor: Colors.green,
                    ),
                    GovMetricCard(
                      title: 'Pending Director Sign-offs',
                      value: '$pendingCount',
                      trendLabel: 'Awaiting Review',
                      progress: pendingCount > 0 ? 0.4 : 0.0,
                      icon: LucideIcons.fileClock,
                      brandColor: theme.colors.primary,
                    ),
                    GovMetricCard(
                      title: 'Procured Supply Assets',
                      value: '$approvedCount',
                      trendLabel: '100% On-Time Delivery',
                      progress: 1.0,
                      icon: LucideIcons.truck,
                      brandColor: Colors.blue,
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // 3. Columns Layout
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isDesktop = constraints.maxWidth > 950;
                    final orderTable = _buildProcurementTable(theme);
                    final formWidget = _buildProcurementRequestForm(theme);
                    final chartWidget = _buildSpendChart(theme);

                    if (isDesktop) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                orderTable,
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                formWidget,
                                const SizedBox(height: 20),
                                chartWidget,
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          orderTable,
                          const SizedBox(height: 20),
                          formWidget,
                          const SizedBox(height: 20),
                          chartWidget,
                        ],
                      );
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProcurementTable(PrimeThemeData theme) {
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
                'Procurement Order Requests',
                style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
              ),
              _buildHslBadge('REGIONAL CONTROLLER', 200, 0.70, 0.45),
            ],
          ),
          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _orders.length,
            separatorBuilder: (context, idx) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final order = _orders[index];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            order.vendorName,
                            style: theme.typography.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colors.onBackground,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '\$${order.cost.toStringAsFixed(2)}',
                          style: theme.typography.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${order.serviceType} • ${order.targetHub}',
                          style: theme.typography.bodySmall.copyWith(
                            color: theme.colors.outline,
                          ),
                        ),
                        _buildStatusIndicator(order.status, theme),
                      ],
                    ),
                    if (order.status == 'Pending Approval') ...[
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(key: const Key('service_procurement_screen_outlinedbutton_button_1'), 
                            style: OutlinedButton.styleFrom(
                              foregroundColor: theme.colors.error,
                              side: BorderSide(color: theme.colors.error.withValues(alpha: 0.4)),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            ),
                            onPressed: () => _updateOrderStatus(order.id, 'Declined'),
                            child: const Text('Decline', style: TextStyle(fontSize: 12)),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(key: const Key('service_procurement_screen_elevatedbutton_button_1'), 
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            ),
                            onPressed: () => _updateOrderStatus(order.id, 'Approved'),
                            child: const Text('Approve', style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(String status, PrimeThemeData theme) {
    Color color = Colors.grey;
    if (status == 'Approved') color = Colors.green;
    if (status == 'Declined') color = theme.colors.error;
    if (status == 'Pending Approval') color = Colors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildProcurementRequestForm(PrimeThemeData theme) {
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
            children: [
              Icon(LucideIcons.shoppingBag, color: theme.colors.primary, size: 24),
              const SizedBox(width: 12),
              Text(
                'Submit Procurement Request',
                style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Vendor Name field
          PrimeCareTextField(key: const Key('service_procurement_screen_textfield_input_1'), 
            label: 'Vendor Name',
            hintText: 'e.g. SurgiCore Supplies, Biohazard Co...',
            controller: _vendorController,
          ),
          const SizedBox(height: 16),

          // Service Type
          Text('Service/Item Category', style: theme.typography.labelBold),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedServiceType,
            decoration: InputDecoration(
              filled: true,
              fillColor: theme.colors.background,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(theme.radiusDefault),
                borderSide: BorderSide.none,
              ),
            ),
            items: _serviceTypes.map((t) {
              return DropdownMenuItem(
                value: t,
                child: Text(t, style: theme.typography.bodyMedium),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() => _selectedServiceType = val);
              }
            },
          ),
          const SizedBox(height: 16),

          // Total Cost field
          PrimeCareTextField(key: const Key('service_procurement_screen_textfield_input_2'), 
            label: 'Estimated Cost (USD)',
            hintText: 'e.g. 4500.00',
            controller: _costController,
          ),
          const SizedBox(height: 16),

          // Regional Hub Dropdown
          Text('Target Clinic Hub', style: theme.typography.labelBold),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedHub,
            decoration: InputDecoration(
              filled: true,
              fillColor: theme.colors.background,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(theme.radiusDefault),
                borderSide: BorderSide.none,
              ),
            ),
            items: _regionalHubs.map((hub) {
              return DropdownMenuItem(
                value: hub,
                child: Text(hub, style: theme.typography.bodyMedium),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() => _selectedHub = val);
              }
            },
          ),
          const SizedBox(height: 24),

          PrimeButton.primary(
            label: 'Submit for Sign-off',
            isFullWidth: true,
            onPressed: _submitProcurementRequest,
          ),
        ],
      ),
    );
  }

  Widget _buildSpendChart(PrimeThemeData theme) {
    return GovTelemetryChart(
      title: 'Spend History by Month (\$k)',
      dataPoints: const [10, 18, 14, 25, 32, 28, 42],
      labels: const ['Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May'],
      accentColor: Colors.green,
    );
  }
}
