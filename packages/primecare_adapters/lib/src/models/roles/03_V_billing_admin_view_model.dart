// Layer: 03_VIEW_MODELS
import 'package:equatable/equatable.dart';

class BillingAdminViewModel extends Equatable {
  final double totalRevenue;
  final double pendingClaims;
  final double collectionRate;
  final int overdueInvoices;
  final List<BillingTrendData> revenueTrend;
  final List<ClaimStatus> recentClaims;
  final bool isOfflineFallback;

  const BillingAdminViewModel({
    required this.totalRevenue,
    required this.pendingClaims,
    required this.collectionRate,
    required this.overdueInvoices,
    required this.revenueTrend,
    required this.recentClaims,
    this.isOfflineFallback = false,
  });

  factory BillingAdminViewModel.empty() => const BillingAdminViewModel(
    totalRevenue: 0,
    pendingClaims: 0,
    collectionRate: 0,
    overdueInvoices: 0,
    revenueTrend: [],
    recentClaims: [],
    isOfflineFallback: true,
  );

  @override
  List<Object?> get props => [
    totalRevenue,
    pendingClaims,
    collectionRate,
    overdueInvoices,
    revenueTrend,
    recentClaims,
    isOfflineFallback,
  ];
}

class BillingTrendData extends Equatable {
  final String label;
  final double value;
  const BillingTrendData(this.label, this.value);
  @override
  List<Object?> get props => [label, value];
}

class ClaimStatus extends Equatable {
  final String id;
  final String patientName;
  final double amount;
  final String status; // e.g., "Pending", "Approved", "Rejected"
  const ClaimStatus(this.id, this.patientName, this.amount, this.status);
  @override
  List<Object?> get props => [id, patientName, amount, status];
}
