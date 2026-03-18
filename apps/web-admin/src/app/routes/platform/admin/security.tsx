import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '../../../../shared/utils/apiClient';
import { useRegistryQuery } from '../../../../shared/hooks/useRegistryQuery';
import { useQueryClient } from '@tanstack/react-query';
import type { TableColumn } from '@/shared/components/sections';
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from D3-AccountingDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D3 · Accounting Dashboard
// Type: Dashboard | Owner: admin | Registry: D3
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function AccountingDashboard() {
    return (
        <PageTemplate
            pageId="D3"
            title="📒 Accounting Dashboard"
            subtitle="Double-entry ledger, P&L, balance sheet & cash flow overview"
            actionPageId="admin.accounting"
            sectionData={PageSectionRegistry['D3']}
        />
    );
}

// --- Merged from L16-AuditTrailViewer.tsx ---
// ================================================================
// PAGE IDENTITY: L16 · Audit Trail Viewer
// Type: List | Owner: admin | Registry: L24
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function AuditTrailViewer() {
    return (
        <PageTemplate
            pageId="L24"
            title="🔍 Audit Trail"
            subtitle="Complete system activity log — who did what, when, and from where"
            actionPageId="admin.audit-trail"
            sectionData={PageSectionRegistry['L24']}
        />
    );
}

// --- Merged from SecurityDashboard.tsx ---
export function SecurityDashboard() {
    return (
        <PageTemplate 
            pageId="PGE-SD" 
            title="✨ Security Dashboard" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-SD']}
        />
    );
}

// --- Merged from T10-SecurityGovernance.tsx ---
// ================================================================
// PAGE IDENTITY: T10 · Security Governance
// Type: Tool | Owner: admin | Registry: T10
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function SecurityGovernance() {
    return (
        <PageTemplate
            pageId="T10"
            title="🛡️ Security Governance"
            subtitle="Threat monitoring, compliance, access reviews & incident response"
            actionPageId="admin.security-governance"
            sectionData={PageSectionRegistry['T10']}
        />
    );
}

// --- Merged from T13-DeviceManagement.tsx ---
// PAGE IDENTITY: T13 · Device Management

export function DeviceManagement() {
    return (
        <PageTemplate pageId="T13" title="📱 Device Management" subtitle="Registered devices, trust levels, remote wipe & session management"
            sectionData={PageSectionRegistry['T13']}
        />
    );
}

// --- Merged from T14-ForensicTrails.tsx ---
// ================================================================
// PAGE IDENTITY: T14 · Forensic Trails
// Type: Tool | Owner: admin | Registry: T14
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function ForensicTrails() {
    return (
        <PageTemplate
            pageId="T14"
            title="🔬 Forensic Trails"
            subtitle="Immutable audit log with full chain-of-custody for compliance & investigations"
            actionPageId="admin.forensic-trails"
            sectionData={PageSectionRegistry['T14']}
        />
    );
}

// --- Merged from T15-CorsSettings.tsx ---
// ================================================================
// PAGE IDENTITY: T15 · CORS Settings
// Type: Tool | Owner: admin | Registry: T15
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function CorsSettings() {
    return (
        <PageTemplate
            pageId="T15"
            title="🌐 CORS Settings"
            subtitle="Cross-Origin Resource Sharing configuration and allowed origins management"
            actionPageId="admin.cors-settings"
            sectionData={PageSectionRegistry['T15']}
        />
    );
}

// --- Merged from T16-IntegrityVerification.tsx ---
// PAGE IDENTITY: T16 · Integrity Verification

export function IntegrityVerification() {
    return (
        <PageTemplate pageId="T16" title="🔒 Integrity Verification" subtitle="Data integrity checks, checksum validation & tamper detection"
            sectionData={PageSectionRegistry['T16']}
        />
    );
}

// --- Merged from T17-FinancialLedger.tsx ---
// ================================================================
// PAGE IDENTITY: T17 · Financial Ledger
// Type: Tool | Owner: admin | Registry: T17
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function FinancialLedger() {
    return (
        <PageTemplate
            pageId="T17"
            title="📒 Financial Ledger"
            subtitle="Double-entry journal, general ledger, trial balance & reconciliation"
            actionPageId="admin.financial-ledger"
            sectionData={PageSectionRegistry['T17']}
        />
    );
}

// --- Merged from T18-TaxComplianceHub.tsx ---
// ================================================================
// PAGE IDENTITY: T18 · Tax Compliance Hub
// Type: Tool | Owner: admin | Registry: T18
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function TaxComplianceHub() {
    return (
        <PageTemplate
            pageId="T18"
            title="🏛️ Tax Compliance Hub"
            subtitle="HST/GST filing, WSIB, T4 generation, EHT & CRA audit trail"
            actionPageId="admin.tax-compliance"
            sectionData={PageSectionRegistry['T18']}
        />
    );
}

// --- Merged from T56-PermissionGrid.tsx ---
// ================================================================
// PAGE IDENTITY: T56 · Permission Grid
// Type: Tool | Owner: admin | Registry: T56
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function PermissionGrid() {
    return (
        <PageTemplate
            pageId="T56"
            title="🔒 Permission Grid"
            subtitle="Role-based access control matrix, permission audits & conflict detection"
            actionPageId="admin.permission-grid"
            sectionData={PageSectionRegistry['T56']}
        />
    );
}

// --- Merged from T57-SessionMonitor.tsx ---
// ================================================================
// PAGE IDENTITY: T57 · Session Monitor
// Type: Tool | Owner: admin | Registry: T57
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function SessionMonitor() {
    return (
        <PageTemplate
            pageId="T57"
            title="📡 Session Monitor"
            subtitle="Real-time active sessions, suspicious activity detection & session management"
            actionPageId="admin.session-monitor"
            isLive
            sectionData={PageSectionRegistry['T57']}
        />
    );
}

// --- Merged from T58-ThreatDetection.tsx ---
// ================================================================
// PAGE IDENTITY: T58 · Threat Detection
// Type: Tool | Owner: admin | Registry: T58
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function ThreatDetection() {
    return (
        <PageTemplate
            pageId="T58"
            title="🚨 Threat Detection"
            subtitle="Real-time threat monitoring, intrusion detection & automated response"
            actionPageId="admin.threat-detection"
            isLive
            sectionData={PageSectionRegistry['T58']}
        />
    );
}

// --- Merged sidecars ---

/* Merged from deviceHandlers.ts */
// T13 Device Management: interfaces and API handlers extracted


export interface Device {
    id: string; userId: string; deviceId: string; deviceName: string | null;
    deviceType: string | null; lastIp: string | null; status: string;
    isAuthorized: boolean; isTemporary: boolean; expiresAt: string | null;
    lastActiveAt: string; user: { firstName: string | null; lastName: string | null; email: string; };
}

export interface AuditLog { id: string; action: string; resourceType: string; createdAt: string; ipAddress: string | null; metadataJson: any; }

export async function fetchDevices(): Promise<Device[]> {
    try { const res = await apiClient.get('/v1/admin/settings/security/devices'); if (res.ok) return await res.json(); } catch (e) { console.error('Failed to fetch devices:', e); }
    return [];
}

export async function authorizeDevice(id: string): Promise<boolean> {
    try { const res = await apiClient.post(`/v1/admin/settings/security/devices/${id}/authorize`); return res.ok; } catch { return false; }
}

export async function revokeDevice(id: string): Promise<boolean> {
    try { const res = await apiClient.post(`/v1/admin/settings/security/devices/${id}/revoke`); return res.ok; } catch { return false; }
}

export async function fetchDeviceActivity(deviceId: string): Promise<AuditLog[]> {
    try { const res = await apiClient.get(`/v1/admin/settings/security/devices/${deviceId}/activity`); if (res.ok) return await res.json(); } catch (e) { console.error('Failed to fetch activity:', e); }
    return [];
}


/* Merged from useAccountingData.ts */
// D3 — Accounting Dashboard: TypeScript interfaces and data loading hook





const { ApiRegistry } = AdminRegistry;

export interface TradingAccount {
    revenue: number;
    directCosts: number;
    grossProfit: number;
    grossProfitMargin: number;
    breakdown: { revenue: Record<string, number>; directCosts: Record<string, number> };
}

export interface ProfitAndLoss {
    operatingExpenses: number;
    netIncome: number;
    breakdown: { indirectExpenses: Record<string, number> };
}

export interface BalanceSheet {
    date: string;
    assets: { total: number; accounts: Record<string, number> };
    liabilities: { total: number; accounts: Record<string, number> };
    equity: { total: number; accounts: Record<string, number> };
}

export interface ForecastPoint { date: string; projectedCash: number; }

export interface ForecastingResult {
    currentCash: number;
    avgDailyRevenue: number;
    avgDailyBurn: number;
    netDailyFlow: number;
    daysOfRunway: number | 'infinite';
    forecast: ForecastPoint[];
}

const ACCOUNTING_QK = ['platform', 'admin', 'reporting'];

export function useAccountingData(showToast: (msg: string, type: any) => void) {
    const queryClient = useQueryClient();

    // 5 parallel useRegistryQuery hooks (React Query fetches independently & in parallel)
    const { data: tradingAcc = null, isLoading: taLoading } = useRegistryQuery<TradingAccount>(
        ApiRegistry.PLATFORM.ADMIN.REPORTING.TRADING_ACCOUNT,
        { queryKey: [...ACCOUNTING_QK, 'trading-account'], staleTime: 60_000 }
    );

    const { data: pAndL = null, isLoading: plLoading } = useRegistryQuery<ProfitAndLoss>(
        ApiRegistry.PLATFORM.ADMIN.REPORTING.PROFIT_LOSS,
        { queryKey: [...ACCOUNTING_QK, 'profit-loss'], staleTime: 60_000 }
    );

    const { data: balanceSheet = null, isLoading: bsLoading } = useRegistryQuery<BalanceSheet>(
        ApiRegistry.PLATFORM.ADMIN.REPORTING.BALANCE_SHEET,
        { queryKey: [...ACCOUNTING_QK, 'balance-sheet'], staleTime: 60_000 }
    );

    const { data: reconSummary = null, isLoading: reconLoading } = useRegistryQuery<{ unreconciledBankCount: number; unreconciledLedgerCount: number }>(
        ApiRegistry.PLATFORM.ADMIN.REPORTING.RECONCILIATION_SUMMARY,
        { queryKey: [...ACCOUNTING_QK, 'reconciliation-summary'], staleTime: 30_000 }
    );

    const { data: forecastData = null, isLoading: fcLoading } = useRegistryQuery<ForecastingResult>(
        ApiRegistry.PLATFORM.ADMIN.REPORTING.FORECAST,
        { queryKey: [...ACCOUNTING_QK, 'forecast'], staleTime: 60_000 }
    );

    const loading = taLoading || plLoading || bsLoading || reconLoading || fcLoading;

    const loadData = () => {
        queryClient.invalidateQueries({ queryKey: ACCOUNTING_QK });
    };

    const handleAutoReconcile = async () => {
        try {
            const res = await apiClient.post(ApiRegistry.PLATFORM.ADMIN.REPORTING.AUTO_RECONCILE, {});
            if (res.ok) {
                const data = await res.json();
                showToast(`Successfully matched ${data.matchedCount} transactions!`, 'success');
                loadData();
            }
        } catch (error) {
            showToast('Auto-reconciliation failed', 'error');
            console.error('Auto-reconciliation failed:', error);
        }
    };

    return { tradingAcc, pAndL, balanceSheet, reconSummary, forecastData, loading, loadData, handleAutoReconcile };
}


/* Merged from useLedgerData.ts */
// T17 Financial Ledger: interfaces and data loading hook




export interface JournalEntry {
    id: string;
    account: { code: string; name: string };
    debit: number;
    credit: number;
    balanceBefore: number;
    balanceAfter: number;
}

export interface FinancialTransaction {
    id: string;
    type: string;
    referenceId: string;
    amount: number;
    status: string;
    createdAt: string;
    journalEntries: JournalEntry[];
}

export interface AccountBalance {
    code: string;
    name: string;
    type: string;
    balance: number;
}

const LEDGER_QK = ['platform', 'admin', 'financial'];

export function useLedgerData(showToast: (msg: string, type: any) => void) {
    const queryClient = useQueryClient();

    // 4 parallel useRegistryQuery hooks (React Query fetches them independently & in parallel)
    const { data: transactions = [], isLoading: txLoading } = useRegistryQuery<FinancialTransaction[]>(
        '/platform/admin/financial',
        { queryKey: [...LEDGER_QK, 'transactions'], staleTime: 30_000 }
    );

    const { data: balances = [], isLoading: balLoading } = useRegistryQuery<AccountBalance[]>(
        '/platform/admin/financial/balances',
        { queryKey: [...LEDGER_QK, 'balances'], staleTime: 30_000 }
    );

    const { data: pAndL = null, isLoading: plLoading } = useRegistryQuery<any>(
        '/platform/admin/financial/reports/p-and-l',
        { queryKey: [...LEDGER_QK, 'p-and-l'], staleTime: 60_000 }
    );

    const { data: balanceSheet = null, isLoading: bsLoading } = useRegistryQuery<any>(
        '/platform/admin/financial/reports/balance-sheet',
        { queryKey: [...LEDGER_QK, 'balance-sheet'], staleTime: 60_000 }
    );

    const loading = txLoading || balLoading || plLoading || bsLoading;

    const loadData = () => {
        queryClient.invalidateQueries({ queryKey: LEDGER_QK });
    };

    const handleReconcile = async (invoiceTxId: string, paymentTxId: string) => {
        try {
            const res = await apiClient.post('/platform/admin/financial/reconcile', { invoiceTxId, paymentTxId });
            if (res.ok) { showToast('Successfully matched transactions', 'success'); loadData(); }
        } catch (error) {
            console.error('Reconciliation failed', error);
        }
    };

    return { transactions, balances, loading, pAndL, balanceSheet, loadData, handleReconcile };
}

