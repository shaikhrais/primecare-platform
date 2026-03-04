import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { CoreBarChart, CorePieChart } from '@/shared/components/charts/core';

export default function StaffRanker() {
    const { t } = useTranslation();
    const [period, setPeriod] = useState('30d');

    const rankData = [
        { name: 'Sarah Jenkins', attendance: 98, performance: 95, reliability: 99, shifts: 42 },
        { name: 'Michael Chen', attendance: 95, performance: 92, reliability: 94, shifts: 38 },
        { name: 'Amina Okafor', attendance: 99, performance: 88, reliability: 96, shifts: 45 },
        { name: 'David Wilson', attendance: 92, performance: 90, reliability: 85, shifts: 30 },
        { name: 'Elena Rodriguez', attendance: 88, performance: 94, reliability: 82, shifts: 28 },
    ];

    const distributionData = [
        { name: 'Top Tier (90%+)', value: 12, color: '#10b981' },
        { name: 'Good (80-90%)', value: 24, color: '#3b82f6' },
        { name: 'Average (70-80%)', value: 8, color: '#f59e0b' },
        { name: 'At Risk (<70%)', value: 3, color: '#ef4444' },
    ];

    return (
        <div className="p-8 max-w-7xl mx-auto space-y-8 animate-in fade-in duration-500">
            <header className="flex justify-between items-center">
                <div>
                    <h1 className="text-3xl font-black tracking-tight">Staff Performance Ranker</h1>
                    <p className="text-muted-foreground">Identify top performers and optimize branch clinical reliability.</p>
                </div>
                <div className="flex bg-secondary p-1 rounded-xl border">
                    {['7d', '30d', '90d'].map(p => (
                        <button
                            key={p}
                            onClick={() => setPeriod(p)}
                            className={`px-4 py-2 text-xs font-bold rounded-lg transition-all ${period === p ? 'bg-background shadow-sm text-primary' : 'text-muted-foreground hover:text-foreground'}`}
                        >
                            {p.toUpperCase()}
                        </button>
                    ))}
                </div>
            </header>

            <div className="grid grid-cols-1 lg:grid-cols-4 gap-6">
                <div className="lg:col-span-1 space-y-6">
                    <div className="bg-card border rounded-2xl p-6 shadow-sm">
                        <label className="text-[10px] font-black uppercase text-muted-foreground tracking-widest block mb-4">Performance Spread</label>
                        <div className="h-48">
                            <CorePieChart data={distributionData} dataKey="value" nameKey="name" />
                        </div>
                    </div>
                    <div className="bg-primary text-primary-foreground p-6 rounded-2xl space-y-2 shadow-xl shadow-primary/10">
                        <div className="text-xs font-bold opacity-60 uppercase">Branch Average</div>
                        <div className="text-4xl font-black">94.2</div>
                        <div className="text-xs font-medium opacity-80 flex items-center gap-1">
                            <span className="text-green-300">▲ 2.1%</span> vs previous {period}
                        </div>
                    </div>
                </div>

                <div className="lg:col-span-3 bg-card border rounded-2xl p-6 shadow-sm">
                    <h3 className="font-bold text-lg mb-6 flex items-center gap-2">
                        <span>🏆</span> Leaderboard: Clinical Excellence
                    </h3>
                    <div className="overflow-x-auto">
                        <table className="w-full text-left border-collapse">
                            <thead>
                                <tr className="text-xs font-black uppercase text-muted-foreground border-b bg-secondary/30">
                                    <th className="px-4 py-3 first:rounded-tl-lg">Staff Member</th>
                                    <th className="px-4 py-3">Attendance</th>
                                    <th className="px-4 py-3">Performance</th>
                                    <th className="px-4 py-3">Reliability</th>
                                    <th className="px-4 py-3 last:rounded-tr-lg">Shifts</th>
                                </tr>
                            </thead>
                            <tbody>
                                {rankData.map((staff, idx) => (
                                    <tr key={idx} className="border-b last:border-0 hover:bg-accent/5 transition-colors group">
                                        <td className="px-4 py-4 font-bold flex items-center gap-3">
                                            <div className="w-8 h-8 rounded-full bg-secondary flex items-center justify-center text-xs">
                                                {idx === 0 ? '🥇' : idx === 1 ? '🥈' : idx === 2 ? '🥉' : idx + 1}
                                            </div>
                                            {staff.name}
                                        </td>
                                        <td className="px-4 py-4">
                                            <div className="flex items-center gap-2">
                                                <div className="flex-1 h-2 bg-secondary rounded-full overflow-hidden w-20">
                                                    <div className="h-full bg-green-500 rounded-full" style={{ width: `${staff.attendance}%` }} />
                                                </div>
                                                <span className="text-xs font-mono font-bold">{staff.attendance}%</span>
                                            </div>
                                        </td>
                                        <td className="px-4 py-4">
                                            <span className={`px-2 py-1 rounded-md text-xs font-black border ${staff.performance >= 90 ? 'bg-green-500/10 text-green-600 border-green-500/20' : 'bg-blue-500/10 text-blue-600 border-blue-500/20'}`}>
                                                {staff.performance} / 100
                                            </span>
                                        </td>
                                        <td className="px-4 py-4 font-mono text-sm font-bold">{staff.reliability}%</td>
                                        <td className="px-4 py-4">
                                            <span className="text-xs font-bold px-2 py-1 bg-secondary rounded-md">{staff.shifts}</span>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div className="bg-card border rounded-2xl p-6 shadow-sm">
                    <h3 className="font-bold mb-6 text-muted-foreground text-sm uppercase tracking-widest">Attendance Trends</h3>
                    <div className="h-64">
                        <CoreBarChart
                            data={[
                                { date: 'Week 1', attendance: 92 },
                                { date: 'Week 2', attendance: 94 },
                                { date: 'Week 3', attendance: 91 },
                                { date: 'Week 4', attendance: 98 },
                            ]}
                            xKey="date"
                            series={[{ key: 'attendance', name: 'Attendance %', color: '#10b981' }]}
                        />
                    </div>
                </div>
                <div className="bg-card border rounded-2xl p-6 shadow-sm flex flex-col justify-center items-center text-center space-y-4">
                    <div className="text-4xl text-primary opacity-20">📅</div>
                    <h3 className="font-bold text-lg">Next Review Cycle</h3>
                    <p className="text-sm text-muted-foreground max-w-xs mx-auto">
                        Your next automated performance sweep is scheduled for <strong>Monday, March 9th</strong>. You can manually trigger a review for specific staff members.
                    </p>
                    <button className="px-6 py-2 bg-primary text-primary-foreground rounded-lg font-bold text-sm hover:opacity-90 transition-all">
                        Schedule Evaluation
                    </button>
                </div>
            </div>
        </div>
    );
}
