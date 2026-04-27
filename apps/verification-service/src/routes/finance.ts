import { FinanceController } from '../controllers/finance.controller';

export function registerFinanceRoutes(app: any) {
  app.post('/v1/finance/ledger/transaction', (c: any) => FinanceController.recordTransaction(c));
  app.post('/v1/finance/ledger/void/:transactionId', (c: any) => FinanceController.voidTransaction(c));
  app.get('/v1/finance/ledger/tax-report', (c: any) => FinanceController.getTaxReport(c));
  app.get('/v1/finance/currency/convert', (c: any) => FinanceController.convertCurrency(c));
  app.get('/v1/finance/compliance/calculate-tax', (c: any) => FinanceController.calculateTax(c));
}
