import React from 'react';
import { CoreBarChart, CorePieChart } from '@/shared/components/charts/core';

const FinanceRegionalHub: React.FC = () => {
    const revenueData = [
        { name: 'Week 1', value: 45000 },
        { name: 'Week 2', value: 52000 },
        { name: 'Week 3', value: 48000 },
        { name: 'Week 4', value: 61000 }
    ];

    const expenseSplit = [
        { name: 'Staffing', value: 65, color: '#6366f1' },
        { name: 'Operations', value: 20, color: '#f59e0b' },
        { name: 'Marketing', value: 10, color: '#ec4899' },
        { name: 'Overhead', value: 5, color: '#94a3b8' }
    ];

    return (
        <div className="p-6 space-y-6 max-w-[1600px] mx-auto animate-in fade-in slide-in-from-bottom-4 duration-500">
            <header className="flex justify-between items-end">
                <div>
                    <h1 className="text-3xl font-black text-slate-900 tracking-tight text-transparent bg-clip-text bg-gradient-to-r from-slate-900 to-slate-500">FINANCE & GOVERNANCE</h1>
                    <p className="text-slate-500 font-medium tracking-wide">Regional Profitability & Operational Health</p>
                </div>
                <div className="flex gap-3">
                    <button className="px-6 py-2.5 bg-white border border-slate-200 rounded-2xl font-bold text-sm shadow-sm hover:shadow-md transition-all">
                        P&L Export
                    </button>
                    <button className="px-6 py-2.5 bg-slate-900 text-white rounded-2xl font-bold text-sm shadow-lg shadow-slate-200 hover:bg-slate-800 transition-all">
                        Audit Request
                    </button>
                </div>
            </header>

            <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
                {[
                    { label: 'Monthly Revenue', val: '$206K', change: '+8.4%', color: 'indigo' },
                    { label: 'EBITDA Margin', val: '24.2%', change: '+1.2%', color: 'emerald' },
                    { label: 'Overtime Cost', val: '$12.4K', change: '-15%', color: 'emerald' },
                    { label: 'Accounts Receivable', val: '$45K', change: '80% Current', color: 'amber' }
                ].map(stat => (
                    <div key={stat.label} className="bg-white p-7 rounded-[32px] border border-slate-100 shadow-sm relative overflow-hidden group">
                        <div className={`absolute top-0 right-0 w-24 h-24 -mr-8 -mt-8 bg-slate-50 rounded-full group-hover:scale-110 transition-transform duration-500`} />
                        <p className="text-slate-400 text-[10px] font-black uppercase tracking-widest mb-2 relative z-10">{stat.label}</p>
                        <div className="flex items-end gap-3 relative z-10">
                            <h4 className="text-3xl font-black text-slate-800 tracking-tight">{stat.val}</h4>
                            <span className={`text-xs font-bold mb-1 ${stat.change.startsWith('+') || stat.label.includes('Overtime') && stat.change.startsWith('-') ? 'text-emerald-500' : 'text-rose-500'}`}>{stat.change}</span>
                        </div>
                    </div>
                ))}
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div className="bg-white p-8 rounded-[40px] border border-slate-100 shadow-sm">
                    <h3 className="text-slate-400 font-black text-[10px] uppercase tracking-widest mb-8 border-b border-slate-50 pb-4">Revenue Velocity (Rolling 4-Week)</h3>
                    <div className="h-64">
                        <CoreBarChart
                            data={revenueData}
                            xKey="name"
                            series={[{ key: 'value', color: '#0f172a', name: 'Revenue' }]}
                        />
                    </div>
                </div>

                <div className="bg-white p-8 rounded-[40px] border border-slate-100 shadow-sm flex flex-col items-center">
                    <h3 className="text-slate-400 font-black text-[10px] uppercase tracking-widest mb-8 border-b border-slate-50 pb-4 w-full">Expense Distribution</h3>
                    <div className="w-full h-64">
                        <CorePieChart
                            data={expenseSplit}
                            dataKey="value"
                            nameKey="name"
                        />
                    </div>
                    <div className="grid grid-cols-2 gap-8 w-full mt-4">
                        {expenseSplit.map(s => (
                            <div key={s.name} className="flex justify-between items-center px-4 py-2 bg-slate-50 rounded-xl">
                                <span className="text-xs font-bold text-slate-600">{s.name}</span>
                                <span className="text-sm font-black text-slate-900">{s.value}%</span>
                            </div>
                        ))}
                    </div>
                </div>
            </div>

            <div className="bg-slate-900 rounded-[40px] shadow-2xl p-10 text-white flex flex-col md:flex-row justify-between items-center gap-8">
                <div className="max-w-md">
                    <h2 className="text-2xl font-black mb-2 tracking-tight">Consolidated Regional Audit</h2>
                    <p className="text-slate-400 text-sm leading-relaxed">Your region is currently in **'Excellence'** status. No critical financial discrepancies detected in the last 72 hours.</p>
                </div>
                <div className="flex gap-4 w-full md:w-auto">
                    <div className="flex-1 md:flex-none px-8 py-4 bg-white/5 border border-white/10 rounded-3xl text-center">
                        <p className="text-[10px] font-black text-indigo-400 uppercase tracking-widest mb-1">Compliance Score</p>
                        <p className="text-2xl font-black">98.4%</p>
                    </div>
                    <div className="flex-1 md:flex-none px-8 py-4 bg-white/5 border border-white/10 rounded-3xl text-center">
                        <p className="text-[10px] font-black text-emerald-400 uppercase tracking-widest mb-1">Audit Depth</p>
                        <p className="text-2xl font-black">Full</p>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default FinanceRegionalHub;
