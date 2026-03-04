import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { CoreAreaChart, CoreRadialBarChart } from '@/shared/components/charts/core';

export default function BranchPL() {
    const { t } = useTranslation();
    const [period, setPeriod] = useState('Quarterly');

    const revenueData = [
        { month: 'Jan', revenue: 120000, expenses: 85000, profit: 35000 },
        { month: 'Feb', revenue: 145000, expenses: 92000, profit: 53000 },
        { month: 'Mar', revenue: 138000, expenses: 95000, profit: 43000 },
        { month: 'Apr', revenue: 160000, expenses: 105000, profit: 55000 },
        { month: 'May', revenue: 175000, expenses: 110000, profit: 65000 },
        { month: 'Jun', revenue: 190000, expenses: 120000, profit: 70000 },
    ];

    const expenseDistribution = [
        { name: 'Payroll', value: 65, color: '#3b82f6' },
        { name: 'Logistics', value: 15, color: '#10b981' },
        { name: 'Marketing', value: 10, color: '#f59e0b' },
        { name: 'Ops/Overhead', value: 10, color: '#6366f1' },
    ];

    return (
        <div className="p-8 max-w-7xl mx-auto space-y-8 animate-in fade-in slide-in-from-top-4 duration-700">
            <header className="flex justify-between items-end border-b pb-8">
                <div>
                    <div className="text-xs font-black text-primary uppercase tracking-widest mb-1">Financial Intelligence</div>
                    <h1 className="text-4xl font-black tracking-tight">Branch Profit & Loss</h1>
                    <p className="text-muted-foreground mt-1">Real-time financial performance and operational expense audit.</p>
                </div>
                <div className="flex gap-4">
                    <select
                        className="bg-background border rounded-xl px-4 py-2 text-sm font-bold shadow-sm outline-none focus:ring-2 focus:ring-primary/20"
                        value={period}
                        onChange={(e) => setPeriod(e.target.value)}
                    >
                        <option>Monthly</option>
                        <option>Quarterly</option>
                        <option>Year-to-Date</option>
                    </select>
                    <button className="bg-primary text-primary-foreground px-6 py-2 rounded-xl font-bold text-sm shadow-lg shadow-primary/20 hover:opacity-90 transition-all">
                        Export Statement
                    </button>
                </div>
            </header>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                {[
                    { label: 'Gross Revenue', value: '$928,000', change: '+14.2%', color: 'text-primary' },
                    { label: 'Total Expenses', value: '$607,000', change: '+8.1%', color: 'text-orange-500' },
                    { label: 'Net Profit', value: '$321,000', change: '+22.5%', color: 'text-green-600' }
                ].map((stat, idx) => (
                    <div key={idx} className="bg-card border rounded-3xl p-8 shadow-sm hover:shadow-md transition-shadow relative overflow-hidden group">
                        <div className="relative z-10">
                            <span className="text-[10px] font-black uppercase text-muted-foreground tracking-tighter">{stat.label}</span>
                            <div className={`text-3xl font-black mt-1 ${stat.color}`}>{stat.value}</div>
                            <div className="text-xs font-bold mt-2 flex items-center gap-1">
                                <span className={stat.change.startsWith('+') ? 'text-green-500' : 'text-red-500'}>
                                    {stat.change}
                                </span>
                                <span className="text-muted-foreground opacity-50">vs last period</span>
                            </div>
                        </div>
                        <div className="absolute -right-4 -bottom-4 text-8xl opacity-[0.03] grayscale font-black transition-all group-hover:scale-110 group-hover:-rotate-12 select-none">
                            {idx === 0 ? '💰' : idx === 1 ? '💸' : '📈'}
                        </div>
                    </div>
                ))}
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <div className="lg:col-span-2 bg-card border rounded-3xl p-8 shadow-sm">
                    <div className="flex justify-between items-center mb-8">
                        <h3 className="font-bold text-xl">Revenue vs Expense Trend</h3>
                        <div className="flex gap-4 text-[10px] font-black uppercase tracking-widest">
                            <div className="flex items-center gap-1.5"><span className="w-2 h-2 rounded-full bg-blue-500"></span> Revenue</div>
                            <div className="flex items-center gap-1.5"><span className="w-2 h-2 rounded-full bg-zinc-300"></span> Expenses</div>
                        </div>
                    </div>
                    <div className="h-[400px]">
                        <CoreAreaChart
                            data={revenueData}
                            xKey="month"
                            series={[
                                { key: 'revenue', name: 'Revenue', color: '#3b82f6' },
                                { key: 'expenses', name: 'Expenses', color: '#d1d5db' }
                            ]}
                        />
                    </div>
                </div>

                <div className="space-y-8">
                    <div className="bg-card border rounded-3xl p-8 shadow-sm">
                        <h3 className="font-bold text-lg mb-6">Expense Distribution</h3>
                        <div className="h-[250px] relative">
                            <CoreRadialBarChart
                                data={expenseDistribution}
                                dataKey="value"
                                nameKey="name"
                            />
                            {/* Overlay Legend */}
                            <div className="absolute inset-x-0 bottom-0 grid grid-cols-2 gap-2">
                                {expenseDistribution.map(exp => (
                                    <div key={exp.name} className="flex items-center gap-2 text-[10px] font-bold">
                                        <div className="w-2 h-2 rounded-full" style={{ backgroundColor: exp.color }} />
                                        <span className="text-muted-foreground uppercase">{exp.name}</span>
                                        <span className="ml-auto">{exp.value}%</span>
                                    </div>
                                ))}
                            </div>
                        </div>
                    </div>

                    <div className="bg-zinc-900 text-white rounded-3xl p-8 space-y-4">
                        <h3 className="font-bold text-primary text-sm uppercase tracking-widest">Efficiency Insight</h3>
                        <p className="text-sm text-zinc-400 leading-relaxed font-medium">
                            Branch profit margins have increased by <span className="text-white">4.2%</span> this quarter due to optimized travel routing for PSWs, reducing average fuel reimbursement costs.
                        </p>
                        <div className="pt-4 border-t border-white/5">
                            <button className="text-xs font-black text-primary hover:underline transition-all">
                                VIEW LOGISTICS AUDIT →
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
