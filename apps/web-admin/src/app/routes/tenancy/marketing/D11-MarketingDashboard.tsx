// ================================================================
// PAGE IDENTITY: D11 � Marketing Dashboard
// Type: Dashboard | Owner: marketing
// ================================================================
import React from 'react';
import { CorePieChart, CoreBarChart } from '@/shared/components/charts/core';

const MarketingDashboard: React.FC = () => {
    const leadStats = [
        { name: 'Inquiry', value: 45, color: '#6366f1' },
        { name: 'Assessment', value: 25, color: '#8b5cf6' },
        { name: 'Onboarding', value: 15, color: '#ec4899' },
        { name: 'Active', value: 15, color: '#10b981' }
    ];

    const growthData = [
        { name: 'Jan', value: 12 },
        { name: 'Feb', value: 19 },
        { name: 'Mar', value: 25 },
        { name: 'Apr', value: 32 },
        { name: 'May', value: 45 }
    ];

    return (
        <div data-cy="page.container" role="main" aria-label="Marketing" className="p-6 space-y-6 max-w-[1600px] mx-auto animate-in fade-in slide-in-from-bottom-4 duration-500">
            <header className="flex justify-between items-end">
                <div>
                    <h1 data-cy="page.title" className="text-3xl font-black text-slate-900 tracking-tight">GROWTH PIPELINE</h1>
                    <p className="text-slate-500 font-medium">Marketing & Lead Conversion Intelligence</p>
                </div>
                <div className="flex gap-3">
                    <button data-cy="btn-marketing-dashboard-0" className="px-4 py-2 bg-white border border-slate-200 rounded-xl font-bold text-sm shadow-sm hover:bg-slate-50 transition-all">
                        Export CRM
                    </button>
                    <button data-cy="btn-marketing-dashboard-1" className="px-4 py-2 bg-indigo-600 text-white rounded-xl font-bold text-sm shadow-lg shadow-indigo-100 hover:bg-indigo-700 transition-all">
                        New Campaign
                    </button>
                </div>
            </header>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div className="bg-white p-8 rounded-3xl shadow-sm border border-slate-100 flex flex-col justify-center items-center">
                    <h3 data-cy="h3-marketing-dashboard-0" className="text-slate-400 font-black text-[10px] uppercase tracking-widest mb-4">Lead Distribution</h3>
                    <div className="w-full h-48">
                        <CorePieChart
                            data={leadStats}
                            dataKey="value"
                            nameKey="name"
                        />
                    </div>
                    <div className="grid grid-cols-2 gap-4 mt-6 w-full">
                        {leadStats.map(s => (
                            <div key={s.name} className="flex items-center gap-2">
                                <div className="w-2 h-2 rounded-full" style={{ backgroundColor: s.color }} />
                                <span className="text-xs font-bold text-slate-600">{s.name}</span>
                            </div>
                        ))}
                    </div>
                </div>

                <div className="md:col-span-2 bg-slate-900 p-8 rounded-3xl shadow-xl text-white relative overflow-hidden">
                    <div className="absolute top-0 right-0 p-8 opacity-10">
                        <span className="text-8xl font-black tracking-tighter">📈</span>
                    </div>
                    <h3 data-cy="h3-marketing-dashboard-1" className="text-indigo-400 font-black text-[10px] uppercase tracking-widest mb-6">Client Acquisition Trend</h3>
                    <div className="h-64">
                        <CoreBarChart
                            data={growthData}
                            xKey="name"
                            series={[{ key: 'value', color: '#818cf8', name: 'Growth' }]}
                        />
                    </div>
                </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
                {[
                    { label: 'Total Leads', val: '124', change: '+12%', color: 'indigo' },
                    { label: 'Conv. Rate', val: '18.4%', change: '+2.1%', color: 'emerald' },
                    { label: 'CAC', val: '$240', change: '-$15', color: 'rose' },
                    { label: 'ROI', val: '4.2x', change: '+0.4x', color: 'amber' }
                ].map(stat => (
                    <div key={stat.label} className="bg-white p-6 rounded-3xl border border-slate-100 shadow-sm group hover:border-indigo-200 transition-all">
                        <p className="text-slate-400 text-xs font-black uppercase tracking-widest mb-2">{stat.label}</p>
                        <div className="flex items-end gap-3">
                            <h4 className="text-3xl font-black text-slate-800 tracking-tight">{stat.val}</h4>
                            <span className={`text-xs font-bold mb-1 ${stat.change.startsWith('+') ? 'text-emerald-500' : 'text-rose-500'
                                }`}>{stat.change}</span>
                        </div>
                    </div>
                ))}
            </div>

            <div className="bg-white rounded-3xl border border-slate-100 shadow-sm overflow-hidden">
                <div className="p-6 border-b border-slate-50 flex justify-between items-center bg-slate-50/50">
                    <h2 data-cy="h2-marketing-dashboard-0" className="font-bold text-slate-800">Recent High-Value Targets</h2>
                    <span className="text-xs font-bold text-indigo-600 cursor-pointer hover:underline">View CRM</span>
                </div>
                <div className="divide-y divide-slate-50">
                    {[
                        { name: 'Sarah Jenkins', source: 'Google Ads', status: 'Assessment', date: '2h ago' },
                        { name: 'Heritage Oaks Facility', source: 'Referral', status: 'Inquiry', date: '5h ago' },
                        { name: 'Michael Chen', source: 'Organic', status: 'Onboarding', date: '1d ago' }
                    ].map(lead => (
                        <div key={lead.name} className="p-4 flex justify-between items-center hover:bg-slate-50 transition-colors">
                            <div className="flex items-center gap-4">
                                <div className="w-10 h-10 rounded-full bg-slate-100 flex items-center justify-center font-bold text-slate-400">
                                    {lead.name.charAt(0)}
                                </div>
                                <div>
                                    <p className="font-bold text-slate-800 leading-none mb-1">{lead.name}</p>
                                    <p className="text-xs text-slate-400">{lead.source}</p>
                                </div>
                            </div>
                            <div className="flex items-center gap-6">
                                <span className="px-3 py-1 bg-indigo-50 text-indigo-600 rounded-full text-[10px] font-black uppercase tracking-tighter">
                                    {lead.status}
                                </span>
                                <span className="text-xs text-slate-300 font-mono">{lead.date}</span>
                            </div>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    );
};

export default MarketingDashboard;
