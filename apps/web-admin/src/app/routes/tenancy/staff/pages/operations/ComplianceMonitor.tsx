import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { CorePieChart } from '@/shared/components/charts/core';

interface ComplianceItem {
    id: string;
    staffName: string;
    document: string;
    expiry: string;
    status: 'compliant' | 'warning' | 'expired';
}

export default function ComplianceMonitor() {
    const { t } = useTranslation();
    const [items] = useState<ComplianceItem[]>([
        { id: '1', staffName: 'Sarah Jenkins', document: 'CPR Level C', expiry: '2026-12-15', status: 'compliant' },
        { id: '2', staffName: 'Michael Chen', document: 'Vulnerable Sector Screen', expiry: '2026-03-20', status: 'warning' },
        { id: '3', staffName: 'Elena Rodriguez', document: 'Clinical License', expiry: '2026-02-10', status: 'expired' },
        { id: '4', staffName: 'David Kim', document: 'WHMIS Training', expiry: '2028-05-01', status: 'compliant' },
    ]);

    const stats = [
        { name: 'Compliant', value: 85, color: '#10b981' },
        { name: 'Warning', value: 10, color: '#f59e0b' },
        { name: 'Expired', value: 5, color: '#ef4444' },
    ];

    return (
        <div className="p-8 max-w-7xl mx-auto space-y-8 animate-in fade-in zoom-in-95 duration-700">
            <header className="flex justify-between items-end">
                <div>
                    <div className="flex items-center gap-3 mb-2">
                        <span className="bg-primary/10 text-primary px-3 py-1 rounded-lg text-[10px] font-black uppercase tracking-widest border border-primary/20">Branch HQ</span>
                        <span className="text-muted-foreground text-[10px] font-black uppercase tracking-widest opacity-40">Regional Audit</span>
                    </div>
                    <h1 className="text-3xl font-black tracking-tight uppercase">Compliance Scorecard</h1>
                    <p className="text-muted-foreground font-medium">Visualizing branch-level clinical verification and registry health.</p>
                </div>
                <div className="flex gap-4">
                    <button className="bg-zinc-100 hover:bg-zinc-200 text-zinc-900 px-6 py-3 rounded-2xl font-black text-xs uppercase tracking-widest transition-all">
                        Run Batch Audit
                    </button>
                </div>
            </header>

            <div className="grid grid-cols-1 lg:grid-cols-12 gap-8">
                <div className="lg:col-span-4 bg-zinc-900 rounded-[3rem] p-10 text-white shadow-2xl relative overflow-hidden">
                    <div className="absolute inset-0 opacity-10 pointer-events-none select-none overflow-hidden">
                        <div className="flex flex-wrap gap-4 rotate-12 -translate-y-10">
                            {Array.from({ length: 40 }).map((_, i) => (
                                <div key={i} className="text-xl font-black opacity-20">CERTIFIED</div>
                            ))}
                        </div>
                    </div>

                    <div className="relative z-10">
                        <h3 className="font-black uppercase tracking-widest text-xs text-white/50 mb-8">Clinical Integrity Distribution</h3>
                        <div className="h-64 mb-10">
                            <CorePieChart data={stats} dataKey="value" nameKey="name" colors={stats.map(s => s.color)} />
                        </div>
                        <div className="space-y-4">
                            {stats.map((s, i) => (
                                <div key={i} className="flex justify-between items-center bg-white/5 p-4 rounded-2xl border border-white/10 hover:bg-white/10 transition-all">
                                    <div className="flex items-center gap-3">
                                        <div className="w-2 h-2 rounded-full" style={{ background: s.color }} />
                                        <span className="text-[10px] font-black uppercase tracking-widest">{s.name}</span>
                                    </div>
                                    <span className="font-black text-sm">{s.value}%</span>
                                </div>
                            ))}
                        </div>
                    </div>
                </div>

                <div className="lg:col-span-8 space-y-6">
                    <div className="bg-card border-2 border-zinc-100 rounded-[2.5rem] p-8 shadow-sm">
                        <div className="flex justify-between items-center mb-8 px-2">
                            <h3 className="font-black uppercase tracking-widest text-xs text-muted-foreground">Compliance Ledger</h3>
                            <div className="flex items-center gap-2">
                                <span className="w-2 h-2 rounded-full bg-red-500" />
                                <span className="text-[10px] font-black uppercase tracking-widest text-red-600">3 critical documents expired</span>
                            </div>
                        </div>

                        <div className="grid grid-cols-1 gap-4">
                            {items.map(item => (
                                <div key={item.id} className="group flex items-center justify-between p-6 bg-zinc-50 border border-zinc-100 rounded-3xl hover:bg-white hover:border-primary/40 hover:shadow-xl transition-all cursor-pointer">
                                    <div className="flex items-center gap-6">
                                        <div className={`w-12 h-12 rounded-2xl flex items-center justify-center text-xl shadow-inner ${item.status === 'expired' ? 'bg-red-50 text-red-500 border border-red-100' :
                                                item.status === 'warning' ? 'bg-amber-50 text-amber-500 border border-amber-100' :
                                                    'bg-green-50 text-green-500 border border-green-100'
                                            }`}>
                                            {item.status === 'expired' ? '🚫' : item.status === 'warning' ? '⏳' : '✅'}
                                        </div>
                                        <div>
                                            <div className="font-black text-sm">{item.staffName}</div>
                                            <div className="text-[10px] font-bold text-muted-foreground uppercase tracking-widest mt-1">
                                                {item.document} • Expiry: {item.expiry}
                                            </div>
                                        </div>
                                    </div>

                                    <div className="flex items-center gap-6">
                                        <div className={`px-4 py-2 rounded-xl text-[9px] font-black uppercase tracking-widest border-2 ${item.status === 'compliant' ? 'bg-green-50 border-green-100 text-green-600' :
                                                item.status === 'warning' ? 'bg-amber-50 border-amber-100 text-amber-600' :
                                                    'bg-red-50 border-red-100 text-red-600'
                                            }`}>
                                            {item.status}
                                        </div>
                                        <button className="bg-white hover:bg-zinc-50 border-2 border-zinc-100 px-6 py-2.5 rounded-xl font-black text-[10px] uppercase tracking-widest opacity-0 group-hover:opacity-100 transition-all">
                                            Verify Docs
                                        </button>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>

                    <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div className="bg-primary/5 border-2 border-dashed border-primary/20 p-8 rounded-[2rem] flex items-center gap-6">
                            <div className="bg-primary/20 p-4 rounded-2xl text-2xl">📢</div>
                            <div>
                                <h3 className="font-black text-xs uppercase tracking-widest text-primary mb-1">Send Mass Notice</h3>
                                <p className="text-[10px] font-medium text-primary/60 leading-tight">Notify all staff with expiring documents via SMS/Portal.</p>
                            </div>
                        </div>
                        <div className="bg-card border-2 border-zinc-100 p-8 rounded-[2rem] flex items-center gap-6 hover:border-zinc-300 transition-all cursor-pointer group">
                            <div className="bg-zinc-100 p-4 rounded-2xl text-2xl grayscale group-hover:grayscale-0 transition-all">📁</div>
                            <div>
                                <h3 className="font-black text-xs uppercase tracking-widest text-muted-foreground group-hover:text-zinc-900 transition-all mb-1">Registry Export</h3>
                                <p className="text-[10px] font-medium text-muted-foreground/60 leading-tight italic">Generate compliance package for audit.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
