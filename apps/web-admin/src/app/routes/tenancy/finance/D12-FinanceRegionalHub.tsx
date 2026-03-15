// ================================================================
// PAGE IDENTITY: D12 � Finance Regional Hub
// Type: Dashboard | Owner: finance
// ================================================================
import React, { useEffect, useState } from 'react';
import { CoreBarChart, CorePieChart } from '@/shared/components/charts/core';
import { AdminRegistry } from 'prime-care-shared';
import './FinanceRegionalHub.css';

const { ContentRegistry } = AdminRegistry;

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

    const stats = [
        { label: 'Monthly Revenue', val: '$206K', change: '+8.4%', pos: true },
        { label: 'EBITDA Margin', val: '24.2%', change: '+1.2%', pos: true },
        { label: 'Overtime Cost', val: '$12.4K', change: '-15%', pos: true },
        { label: 'Accounts Receivable', val: '$45K', change: '80% Current', pos: true }
    ];

    return (
        <div data-cy="page.container" role="main" aria-label="Finance Regional" className="finance-regional-hub">
            <header className="finance-header">
                <div className="mgr-title-group">
                    <h1 data-cy="page.title">FINANCE & GOVERNANCE</h1>
                    <p>Regional Profitability & Operational Health</p>
                </div>
                <div className="finance-btn-group">
                    <button data-cy="btn-finance-regional-hub-0" className="btn-finance-secondary">P&L Export</button>
                    <button data-cy="btn-finance-regional-hub-1" className="btn-finance-primary">Audit Request</button>
                </div>
            </header>

            <div className="finance-grid">
                {stats.map(stat => (
                    <div key={stat.label} className="finance-stat-card">
                        <span className="stat-label">{stat.label}</span>
                        <div className="flex items-baseline">
                            <span className="stat-value">{stat.val}</span>
                            <span className={`stat-change ${stat.pos ? 'change-positive' : 'change-negative'}`}>{stat.change}</span>
                        </div>
                    </div>
                ))}
            </div>

            <div className="charts-row">
                <div className="finance-chart-card">
                    <h3 data-cy="h3-finance-regional-hub-0" className="chart-title">Revenue Velocity (Rolling 4-Week)</h3>
                    <div className="h-64">
                        <CoreBarChart
                            data={revenueData}
                            xKey="name"
                            series={[{ key: 'value', color: '#0f172a', name: 'Revenue' }]}
                        />
                    </div>
                </div>

                <div className="finance-chart-card flex flex-col items-center">
                    <h3 data-cy="h3-finance-regional-hub-1" className="chart-title w-full">Expense Distribution</h3>
                    <div className="w-full h-64">
                        <CorePieChart
                            data={expenseSplit}
                            dataKey="value"
                            nameKey="name"
                        />
                    </div>
                    <div className="grid grid-cols-2 gap-4 w-full mt-8">
                        {expenseSplit.map(s => (
                            <div key={s.name} className="flex justify-between items-center px-4 py-2 bg-slate-50 rounded-xl">
                                <span className="text-xs font-bold text-slate-600">{s.name}</span>
                                <span className="text-sm font-black text-slate-900">{s.value}%</span>
                            </div>
                        ))}
                    </div>
                </div>
            </div>

            <div className="audit-banner">
                <div className="audit-info">
                    <h2>Consolidated Regional Audit</h2>
                    <p>Your region is currently in **'Excellence'** status. No critical financial discrepancies detected in the last 72 hours.</p>
                </div>
                <div className="audit-metrics">
                    <div className="audit-metric-box">
                        <p className="label">Compliance Score</p>
                        <p className="value">98.4%</p>
                    </div>
                    <div className="audit-metric-box">
                        <p className="label">Audit Depth</p>
                        <p className="value">Full</p>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default FinanceRegionalHub;
