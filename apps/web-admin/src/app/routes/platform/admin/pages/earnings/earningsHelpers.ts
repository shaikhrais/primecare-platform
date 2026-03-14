// AdminEarningsPage: export handler and stats calculation extracted
import { EarningRecord } from './earnings.data';

export function calculateStats(earnings: EarningRecord[], t: (key: string) => string, contentRegistry: any) {
    const totalRevenue = earnings.reduce((acc, curr) => acc + curr.revenue, 0);
    const totalPayroll = earnings.reduce((acc, curr) => acc + curr.payroll, 0);
    const netProfit = earnings.reduce((acc, curr) => acc + curr.profit, 0);
    const payoutsPending = earnings.filter(r => r.payoutStatus === 'Pending').reduce((acc, curr) => acc + curr.payroll, 0);
    return [
        { label: t(contentRegistry.EARNINGS.STATS.REVENUE), value: `$${totalRevenue.toLocaleString(undefined, { minimumFractionDigits: 2 })}`, trend: '+12.5%', color: '#00875A' },
        { label: t(contentRegistry.EARNINGS.STATS.PAYROLL), value: `$${totalPayroll.toLocaleString(undefined, { minimumFractionDigits: 2 })}`, trend: '+8.2%', color: '#3B82F6' },
        { label: t(contentRegistry.EARNINGS.STATS.PROFIT), value: `$${netProfit.toLocaleString(undefined, { minimumFractionDigits: 2 })}`, trend: '+18.4%', color: '#8B5CF6' },
        { label: t(contentRegistry.EARNINGS.STATS.PENDING), value: `$${payoutsPending.toLocaleString(undefined, { minimumFractionDigits: 2 })}`, trend: '-5.1%', color: '#F59E0B' },
    ];
}

export function filterEarnings(earnings: EarningRecord[], searchTerm: string, dateRange: { start: string; end: string }): EarningRecord[] {
    let filtered = earnings;
    if (searchTerm) {
        const lowerTerm = searchTerm.toLowerCase();
        filtered = filtered.filter(r => r.id.toLowerCase().includes(lowerTerm) || r.client.toLowerCase().includes(lowerTerm) || r.psw.toLowerCase().includes(lowerTerm) || r.shiftId.toLowerCase().includes(lowerTerm));
    }
    if (dateRange.start) filtered = filtered.filter(r => r.date >= dateRange.start);
    if (dateRange.end) filtered = filtered.filter(r => r.date <= dateRange.end);
    return filtered;
}

export function handleExport(filteredEarnings: EarningRecord[], t: (key: string) => string, contentRegistry: any): void {
    if (filteredEarnings.length === 0) { alert(t(contentRegistry.COMMON.NO_RESULTS)); return; }
    const headers = [t(contentRegistry.EARNINGS.INVOICE_ID), t(contentRegistry.SHARED.STATUS), t(contentRegistry.EARNINGS.CLIENT), t(contentRegistry.EARNINGS.PSW), t(contentRegistry.EARNINGS.REVENUE), t(contentRegistry.EARNINGS.PAYROLL), t(contentRegistry.EARNINGS.PROFIT)];
    const rows = filteredEarnings.map(r => [r.id, r.date, r.shiftId, r.client, r.psw, r.revenue.toFixed(2), r.payroll.toFixed(2), r.profit.toFixed(2), r.paymentStatus]);
    const csvContent = [headers.join(','), ...rows.map(row => row.join(','))].join('\n');
    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.setAttribute('href', url); link.setAttribute('download', `earnings_report_${new Date().toISOString().split('T')[0]}.csv`);
    link.style.visibility = 'hidden'; document.body.appendChild(link); link.click(); document.body.removeChild(link);
}
