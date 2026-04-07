import '../../../../core/config/feature_flags.dart';
import '../../../../core/network/error_mapper.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/models/billing_summary_models.dart';

class BillingSummaryMapper {
  static BillingSummaryViewModel fromMock(Map<String, dynamic> mock) {
    return BillingSummaryViewModel(
      accountId: mock['id'] ?? 'MOCK-BILL',
      totalDue: (mock['due'] ?? 0.0).toDouble(),
      amountPaid: (mock['paid'] ?? 0.0).toDouble(),
      nextDueDate: mock['next'] ?? '2026-05-01',
      isOverdue: mock['late'] ?? false,
    );
  }

  static BillingSummaryViewModel fromApi(BillingSummaryDto dto) {
    return BillingSummaryViewModel(
      accountId: dto.id,
      totalDue: dto.balance.toDouble(),
      amountPaid: dto.paid.toDouble(),
      nextDueDate: dto.deadline,
      isOverdue: dto.pastDue,
    );
  }
}

class BillingSummaryMockProvider {
  Future<BillingSummaryViewModel> getData(String accountId) async {
    return BillingSummaryMapper.fromMock({
      'id': accountId,
      'due': 150.00,
      'paid': 50.00,
      'next': '2026-04-15',
      'late': false,
    });
  }
}

class BillingSummaryApiProvider {
  final ApiClient apiClient;
  BillingSummaryApiProvider(this.apiClient);

  Future<BillingSummaryViewModel> getData(String accountId) async {
    try {
      final response = await apiClient.get('/v1/primecare/billing/summary');
      final dto = BillingSummaryDto(
        id: accountId,
        balance: response.data['totalBilled'] ?? 200.00,
        paid: response.data['pending'] ?? 200.00,
        deadline: response.data['lastPaymentDate'] ?? '2026-04-01',
        pastDue: true,
      );
      return BillingSummaryMapper.fromApi(dto);
    } catch (error) {
      final message = ErrorMapper.mapApiErrorToUiMessage(error);
      return BillingSummaryViewModel(
        accountId: accountId,
        totalDue: 0,
        amountPaid: 0,
        nextDueDate: message,
        isOverdue: false,
      );
    }
  }
}

class BillingSummaryAdapter {
  final BillingSummaryMockProvider mockProvider;
  final BillingSummaryApiProvider apiProvider;

  BillingSummaryAdapter({
    required this.mockProvider,
    required this.apiProvider,
  });

  Future<BillingSummaryViewModel> getData(String accountId) async {
    if (FeatureFlags.useApiForBillingSummary) {
      return apiProvider.getData(accountId);
    }
    return mockProvider.getData(accountId);
  }
}
