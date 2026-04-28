import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { listLedgerRoute, listAccountsRoute, initializeRoute, createInvoiceRoute, getBalancesRoute, reconcileRoute, autoReconcileRoute, reconciliationSummaryRoute, pAndLRoute, balanceSheetRoute, dailySummaryRoute, tradingAccountRoute, forecastRoute, taxFilingRoute, taxRemittanceRoute, earningsRoute, unmatchedReconciliationRoute, executeMatchRoute,
    handleListLedger, handleListAccounts, handleInitialize, handleCreateInvoice, handleGetBalances, handleReconcile, handleAutoReconcile, handleReconciliationSummary, handlePAndL, handleBalanceSheet, handleDailySummary, handleTradingAccount, handleForecast, handleTaxFiling, handleTaxRemittance, handleEarnings, handleUnmatchedReconciliation, handleExecuteMatch
} from './financial-route-defs';

const financial = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

financial.openapi(listLedgerRoute, handleListLedger);
financial.openapi(listAccountsRoute, handleListAccounts);
financial.openapi(initializeRoute, handleInitialize);
financial.openapi(createInvoiceRoute, handleCreateInvoice);
financial.openapi(getBalancesRoute, handleGetBalances);
financial.openapi(reconcileRoute, handleReconcile);
financial.openapi(autoReconcileRoute, handleAutoReconcile);
financial.openapi(reconciliationSummaryRoute, handleReconciliationSummary);
financial.openapi(pAndLRoute, handlePAndL);
financial.openapi(balanceSheetRoute, handleBalanceSheet);
financial.openapi(dailySummaryRoute, handleDailySummary);
financial.openapi(tradingAccountRoute, handleTradingAccount);
financial.openapi(forecastRoute, handleForecast);
financial.openapi(taxFilingRoute, handleTaxFiling);
financial.openapi(taxRemittanceRoute, handleTaxRemittance);
financial.openapi(earningsRoute, handleEarnings);
financial.openapi(unmatchedReconciliationRoute, handleUnmatchedReconciliation);
financial.openapi(executeMatchRoute, handleExecuteMatch);

export default financial;
