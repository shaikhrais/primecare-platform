// ================================================================
// PAGE IDENTITY: T24 � Payroll Verification
// Type: Tool | Owner: manager
// ================================================================
import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { CoreAreaChart } from '@/shared/components/charts/core';

interface PayrollRecord {
    id: string;
    pswName: string;
    totalHours: number;
    scheduledHours: number;
    variance: number;
    status: 'pending' | 'verified' | 'flagged';
    amount: number;
}

export default function PayrollVerification() {
    const { t } = useTranslation();
    const [records, setRecords] = useState<PayrollRecord[]>([
        { id: '1', pswName: 'Sarah Jenkins', totalHours: 38.5, scheduledHours: 40, variance: -1.5, status: 'pending', amount: 962.50 },
        { id: '2', pswName: 'Michael Chen', totalHours: 42.0, scheduledHours: 40, variance: 2.0, status: 'flagged', amount: 1050.00 },
        { id: '3', pswName: 'Elena Rodriguez', totalHours: 40.0, scheduledHours: 40, variance: 0, status: 'pending', amount: 1000.00 },
        { id: '4', pswName: 'David Kim', totalHours: 35.0, scheduledHours: 35, variance: 0, status: 'verified', amount: 875.00 },
    ]);

    const stats = [
        { label: 'Total Payroll', value: '$24,580.00', icon: '💰' },
        { label: 'Pending Audit', value: '12 Providers', icon: '⏳' },
        { label: 'Variance Flags', value: '3 Critical', icon: '🚩' },
    ];

    return (
        <div data-cy="page.container" role="main" aria-label="Payroll Verify" className="p-8 max-w-7xl mx-auto space-y-8 animate-in fade-in zoom-in-95 duration-700">
            <header className="flex justify-between items-end">
                <div>
                    <h1 data-cy="page.title" className="text-3xl font-black tracking-tight uppercase">Payroll Verification</h1>
                    <p className="text-muted-foreground font-medium">Audit clinical hours and finalize regional caregiver payouts.</p>
                </div>
                <div className="flex gap-4">
                    <button data-cy="btn-manager.payroll-verification-0" className="bg-zinc-100 hover:bg-zinc-200 text-zinc-900 px-6 py-3 rounded-2xl font-black text-xs uppercase tracking-widest transition-all">
                        Export Report
                    </button>
                    <button data-cy="btn-manager.payroll-verification-1" className="bg-primary text-primary-foreground px-8 py-3 rounded-2xl font-black text-xs uppercase tracking-widest shadow-xl shadow-primary/20 hover:scale-105 active:scale-95 transition-all">
                        Finalize Regional Payroll
                    </button>
                </div>
            </header>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                {stats.map((stat, i) => (
                    <div key={i} className="bg-card border-2 border-zinc-100 rounded-[2rem] p-8 hover:border-primary/50 transition-all group overflow-hidden relative">
                        <div className="absolute top-0 right-0 p-4 opacity-10 text-6xl group-hover:scale-110 transition-transform">
                            {stat.icon}
                        </div>
                        <div className="text-xs font-black text-muted-foreground uppercase tracking-widest mb-2">{stat.label}</div>
                        <div className="text-4xl font-black tracking-tighter">{stat.value}</div>
                    </div>
                ))}
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <div className="lg:col-span-2 bg-card border-2 border-zinc-100 rounded-[2.5rem] p-8 shadow-sm">
                    <div className="flex justify-between items-center mb-8">
                        <h3 data-cy="h3-manager.payroll-verification-0" className="font-black uppercase tracking-widest text-sm text-muted-foreground">Provider Ledger</h3>
                        <div className="flex gap-2">
                            {['all', 'pending', 'flagged'].map(f => (
                                <button data-cy="btn-manager.payroll-verification-2" key={f} className="px-4 py-2 rounded-xl text-[10px] font-black uppercase tracking-widest bg-zinc-50 hover:bg-zinc-100 border border-zinc-200 transition-all">
                                    {f}
                                </button>
                            ))}
                        </div>
                    </div>

                    <div className="space-y-4">
                        {records.map(record => (
                            <div key={record.id} className="group flex items-center justify-between p-6 bg-zinc-50 border border-zinc-100 rounded-3xl hover:bg-white hover:border-primary/30 hover:shadow-xl hover:shadow-zinc-200/50 transition-all cursor-pointer">
                                <div className="flex items-center gap-6">
                                    <div className="w-12 h-12 rounded-2xl bg-zinc-200 flex items-center justify-center font-black text-xs border-2 border-white shadow-inner">
                                        {record.pswName.split(' ').map(n => n[0]).join('')}
                                    </div>
                                    <div>
                                        <div className="font-black text-sm">{record.pswName}</div>
                                        <div className="text-[10px] font-bold text-muted-foreground uppercase tracking-tighter">
                                            {record.totalHours} hrs vs {record.scheduledHours} scheduled
                                        </div>
                                    </div>
                                </div>

                                <div className="flex items-center gap-12">
                                    <div className="text-right">
                                        <div className="font-black text-sm">${record.amount.toFixed(2)}</div>
                                        <div className={`text-[10px] font-black uppercase tracking-widest ${record.variance >= 0 ? 'text-green-600' : 'text-red-500'}`}>
                                            {record.variance > 0 ? `+${record.variance}` : record.variance}h Variance
                                        </div>
                                    </div>

                                    <div className="flex items-center gap-4">
                                        <span className={`px-4 py-1.5 rounded-full text-[9px] font-black uppercase tracking-widest border-2 ${record.status === 'verified' ? 'bg-green-50 border-green-200 text-green-700' :
                                            record.status === 'flagged' ? 'bg-red-50 border-red-200 text-red-700' :
                                                'bg-yellow-50 border-yellow-200 text-yellow-700'
                                            }`}>
                                            {record.status}
                                        </span>
                                        <button data-cy="btn-manager.payroll-verification-3" className="w-8 h-8 rounded-full flex items-center justify-center bg-white border border-zinc-200 hover:border-primary transition-all text-sm opacity-0 group-hover:opacity-100">
                                            ✓
                                        </button>
                                    </div>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>

                <div className="bg-zinc-900 rounded-[2.5rem] p-8 text-white shadow-2xl relative overflow-hidden">
                    <div className="absolute inset-0 opacity-10 pointer-events-none select-none overflow-hidden">
                        <div className="grid grid-cols-4 gap-4 rotate-12 -translate-y-20">
                            {Array.from({ length: 20 }).map((_, i) => (
                                <div key={i} className="text-4xl text-white">💰</div>
                            ))}
                        </div>
                    </div>

                    <div className="relative z-10">
                        <div className="flex items-center gap-4 mb-8">
                            <div className="bg-primary/20 p-3 rounded-2xl text-xl">📉</div>
                            <div>
                                <h3 data-cy="h3-manager.payroll-verification-1" className="font-black uppercase tracking-widest text-xs">Payroll Trends</h3>
                                <p className="text-[10px] font-medium text-white/50">Regional variance analysis</p>
                            </div>
                        </div>

                        <div className="h-48 mb-6">
                            <CoreAreaChart
                                data={[
                                    { name: 'Mon', value: 4000 },
                                    { name: 'Tue', value: 4200 },
                                    { name: 'Wed', value: 3800 },
                                    { name: 'Thu', value: 4500 },
                                    { name: 'Fri', value: 4100 },
                                ]}
                                xKey="name"
                                series={[{ key: 'value', color: 'var(--brand-500)', name: 'Payroll' }]}
                                showGradient={true}
                            />
                        </div>

                        <div className="space-y-6">
                            <div className="p-6 bg-white/5 rounded-3xl border border-white/10">
                                <div className="text-[10px] font-black uppercase tracking-widest text-white/40 mb-2">Audit Insight</div>
                                <p className="text-xs font-medium leading-relaxed">
                                    Total variance for this period is <span className="text-primary font-black">+4.2h</span>.
                                    Overtime threshold surpassed for 2 providers.
                                </p>
                            </div>
                            <button data-cy="btn-manager.payroll-verification-4" className="w-full bg-white text-zinc-900 py-4 rounded-2xl font-black text-xs uppercase tracking-widest hover:bg-primary hover:text-white transition-all">
                                Review Flags
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
