import 'package:primecare_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class LogPettyCashFormViewModel {
  final bool isLoading;
  final String? status;

  LogPettyCashFormViewModel({
    this.isLoading = false,
    this.status,
  });

  LogPettyCashFormViewModel copyWith({
    bool? isLoading,
    String? status,
  }) {
    return LogPettyCashFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
    );
  }
}

class LogPettyCashFormAdapter extends Notifier<LogPettyCashFormViewModel> {
  @override
  LogPettyCashFormViewModel build() {
    return LogPettyCashFormViewModel();
  }

  Future<bool> submit({
    required double amount,
    required String categoryCode,
    required String merchant,
    required String details,
    required DateTime date,
  }) async {
    state = state.copyWith(isLoading: true);
    final telemetry = ref.read(executionGateProvider);
    final client = ref.read(apiClientProvider);

    telemetry.passGate(
      ExecutionGateCategory.domainApi,
      'Initiating Petty Cash Log: $merchant ($amount)',
      metadata: {'category': categoryCode, 'merchant': merchant},
    );

    final result = await Result.guardFuture<bool>(() async {
      final payload = {
        'type': 'PETTY_CASH',
        'description': 'Petty Cash: $merchant - $details',
        'referenceId': 'PC-${DateTime.now().millisecondsSinceEpoch}',
        'currency': 'CAD',
        'entries': [
          {
            'accountCode': categoryCode, // Debit Expense
            'debit': amount,
            'description': 'Expense: $merchant'
          },
          {
            'accountCode': '1010', // Credit Petty Cash Asset
            'credit': amount,
            'description': 'Credit from Petty Cash'
          }
        ],
        'metadata': {
          'merchant': merchant,
          'date': date.toIso8601String(),
          'details': details
        }
      };

      final response = await client.post('/v1/finance/ledger/transaction', body: payload);
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      }
        return false;
    });

    return result.fold(
      (success) {
        telemetry.passGate(ExecutionGateCategory.domainApi, 'Petty Cash logged successfully');
        state = state.copyWith(isLoading: false, status: 'Success');
        return true;
      },
      (error) {
        telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Petty Cash logging failed',
          error: error,
        );
        state = state.copyWith(isLoading: false, status: 'Error');
        return false;
      },
    );
  }
}

final logPettyCashFormAdapterProvider =
    NotifierProvider<LogPettyCashFormAdapter, LogPettyCashFormViewModel>(() {
  return LogPettyCashFormAdapter();
});

